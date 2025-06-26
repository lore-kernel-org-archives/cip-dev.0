Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0ABC7EE3A
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 09:09:51 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3995.1750928982963462974
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 02:09:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Avsu5tLN;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14C7310397286;
	Thu, 26 Jun 2025 11:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750928981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MtpWx6bPKZhag2ZS3u/bfSTq7leHTHFCt9lWYvfauTc=;
	b=Avsu5tLNDWSvj0pz2sJh+axOmz2wNA4H3FlfZMNKkDn2XiQNeLHOqlWsnXHvaOKgiUTtHc
	f7KQv3rAhsdL7A8xRskEQdS98apdTIuMtnHbkLlVz4PE4xN3+dATmCsQMjLBPvdpuO9Q26
	jio7IkwqL9H++rJUS5ZsWmDqMxynmTy79r9/bnbVLxiNCq0J/mx3lzbs8FxSFiGfCqLyNg
	fmpNH51suujB8QWPpe3d2hgckVUCJsJY0XSWbQj01ZJwYi0so1ClrSY+OnnD/n5mc6cstS
	AQ49p3MrIfutyRtKw7GHu8noBb0YjbTWEt4HyOCoWYwHHhlY2pnqqzZgLr1Y/w==
From: Claudius Heine <ch@denx.de>
Date: Thu, 26 Jun 2025 11:09:27 +0200
Subject: [PATCH v8 4/4] initramfs-crypt-hook: add 'format-if-empty' feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-initramfs-crypt-hook-patches-2-v8-4-46f000788686@denx.de>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
In-Reply-To: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Heinisch Alexander <alexander.heinisch@siemens.com>, 
 Cetin Gokhan <gokhan.cetin@siemens.com>, Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 09:09:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19243

With the A/B update scheme, the goal is to have two (mostly) independent
system slots, one that is active and one that is inactive. The active
system slot writes updates to the inactive system slot and switches the
active and inactive slot via a reboot. Late when booting the new system,
it will decide if the current system is stable and then 'bless' it in
the bootloader, or it will consider the update failed and the system
reboots, without the updated system slot being blessed.

In the last case, the system in the old slot will work as a fallback
system, that reports the failed update back to the backend, and continue
the service, as it has before the update was applied.

It is important here that the update does not modify the fallback system
in any avoidable way, because doing so might break the fallback and make
the system not remotely recoverable.

If encryption is added via an update, there are two cases to consider:

1. Update is applied to the inactive update slot via the normal update
   procedure. In this case the fallback system should not be modified.
2. A system that uses encryption is flashed via a factory flash. In this
   case there is no fallback system and all partitions of both update
   slots need to be encrypted.

To differentiate between these cases, the content of each fallback
partition can be looked at, if they contain data, we are in case (1) and
these partitions should be left alone, if they contain only 0x00, they
can be formatted, because we are in case (2).

The `format-if-empty` option is implemented here, will look if the first
10 MiB of each partition marked with this option contains 0x00 or not
and will either format it or leave it alone.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 doc/README.tpm2.encryption.md                      | 37 ++++++++++++++++------
 .../initramfs-crypt-hook/files/local-top-complete  | 21 ++++++++++++
 ...ypt-hook_0.8.bb => initramfs-crypt-hook_0.9.bb} |  2 +-
 3 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 2256f95a039044313807ab75ce219fa3eb7408b6..6ae2c897901dc4e181f88e4926314ab558870a82 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -12,7 +12,7 @@ passphrase on the device.
 
 Testing with qemu-amd64 requires the package `swtpm`. Under Debian/Ubuntu this can be installed
 
-``` shell
+```shell
 apt-get install swtpm
 ```
 
@@ -23,39 +23,49 @@ or `clevis` (Debian 10 and Debian 11) to enroll a TPM2 protected LUKS passphrase
 The procedure for storing a key is described in [systemd/src/shared/tpm2-util.c](https://github.com/systemd/systemd/blob/0254e4d66af7aa893b31b2326335ded5dde48b51/src/shared/tpm2-util.c#L1395).
 
 ## How to build an QEMU image with TPM encryption
+
 An example for qemu-amd64 can be build with by selecting the option after calling:
 
 ```
 ./kas-container menu
 ```
+
 or by adding using the following command line build:
 
 ```
 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/encrypt-data.yml
 ```
+
 ## initramfs-crypt-hook configuration
 
 The initramfs-crypt-hook recipe has the following variables which can be overwritten during image build:
+
 - CRYPT_PARTITIONS
 - CRYPT_CREATE_FILE_SYSTEM_CMD
 
 ### CRYPT_PARTITIONS
 
 The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
-Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
+Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt | format-if-empty>`.
+
 - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
 - The `mountpoint` is used mount the decrypted partition in the root file system
 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
 - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
 - `noencrypt` will not try to encrypt the partition if it isn't encrypted already, but will open it if it is. See the section [Encrypting the shared partition via an update](#### Encrypting the shared partition via an update) for more information
+- `format-if-empty` will create an empty LUKS partition and format it, like the `format` option, but only if the first 10 MiB are empty (contain only 0x00). This makes it possible to differentiate if a partition is empty and can be encrypted, because it was freshly flashed via a factory image, or if it might contain an unencrypted fallback system and should be left alone.
+
+Power failure safety: Changes to the partition structure or file system super blocks can be dangerous and may result in the system failing to boot if power is cut at a critical point. Efforts were made to either eliminate these critical periods or keep them as short as possible. However, some remain. For example, if writing the LUKS header block is interrupted halfway through, the script and tools may misinterpret the state and be unable to recover.
 
 #### Encrypted root file system
 
 To encrypt the root file system the variable `CRYPT_PARTITIONS` needs to be set to:
+
 ```
 CRYPT_PARTITIONS = "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_UUID_B}::reencrypt"
 ```
-The mountpoint is empty as the root partition is mounted  by a seperate initramfs hook.
+
+The mountpoint is empty as the root partition is mounted by a seperate initramfs hook.
 Both partitions are encrypted during first boot. The initramfs hook opens `${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
 during boot.
 
@@ -78,22 +88,29 @@ The data partition in the fallback system will have the `noencrypt` flag set, wh
 - Update fails at a later point and is not blessed; system reboots into the fallback system on slot A.
 - Fallback system now needs to be able to use the shared data partition.
 
+In this case, where encryption is added via an update, the `format-if-empty` option is also useful. The system with encryption enabled has the `format-if-empty` option set for the partition(s) in the inactive update slot. This will cause both sets of partitions in both slots to be encrypted after the first boot on a fresh factory flashed system, but will not disturb existing data of any fallback system if booted after an update.
+
 ### CRYPT_CREATE_FILE_SYSTEM_CMD
 
 The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
 encrypted partition. The Default (`mke2fs -t ext4`) creates an ext4 partition.
 
 # Convert clevis based encryption to systemd-cryptenroll
+
 ## Prerequisites
+
 The following packages are necessary to convert a clevis based encryption to a systemd-cryptenroll
 based encryption:
- - clevis-luks
- - clevis-tpm2
- - cryptsetup
- - jq
+
+- clevis-luks
+- clevis-tpm2
+- cryptsetup
+- jq
 
 ## steps to convert clevis to systemd
+
 The following script shows how to enroll a systemd-tpm2 token with a existing clevis based encryption:
+
 ```bash
 export device=/dev/sda6
 export keyslot=$(sudo cryptsetup luksDump "$device" --dump-json-metadata | jq -c '.tokens.[] | select( .type == "clevis") | .keyslots | first' | head -n1)
@@ -102,15 +119,17 @@ if [ -n "$keyslot" ]; then
   systemd-cryptenroll --tpm2-device="$tpm_device" --tpm2-pcrs=7 "$device"
 fi
 ```
+
 # TPM2 based encryption on generic x86
 
-For a generic x86 platform with TPM2  module the build can be started with:
+For a generic x86 platform with TPM2 module the build can be started with:
 
 ```bash
 kas-container menu
 ```
 
 The TPM2 module should support:
- - a sha256 pcr bar with the ecc algorithm.
+
+- a sha256 pcr bar with the ecc algorithm.
 
 If only a sha1 pcr bar is avaiable the variable `CRYPT_HASH_TYPE` needs to be set to `sha1`.
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 9038f4b74b94a5c673239da316f0966b77e4b5d3..bd532eb368a601e7c9462da28638bc58de34bf32 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -365,6 +365,27 @@ for partition_set in $partition_sets; do
 			eval "${create_file_system_cmd} ${decrypted_part}"
 			log_end_msg
 		;;
+		"format-if-empty")
+			# Check if first 10MiB contain only zeros, or if it contains a luks
+			# header, but no TPM2 token
+			if cmp -s -n "$(( 10 * 1024 * 1024 ))" "${part_device}" /dev/zero || \
+				( [ "$(get_fstype "${part_device}")" = "luks" ] && \
+				! ( /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" |
+					grep -q "systemd-tpm2\|clevis" ) )
+			then
+				log_begin_msg "Encryption of ${part_device}"
+				/usr/sbin/cryptsetup luksFormat --batch-mode \
+					 --type luks2 "$part_device" < "$tmp_key"
+				enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
+				tpm2_key_del
+				open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
+				eval "${create_file_system_cmd} ${decrypted_part}"
+				log_end_msg
+			else
+				# If not empty, leave it alone.
+				continue
+			fi
+		;;
 		*)
 			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
 		;;
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
similarity index 98%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
index b7884aff741df69eee88d5def94868c66f541126..64e43a8147e13b96154e6afbbe211ee3d9d4cab3 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.8.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.9.bb
@@ -40,7 +40,7 @@ HOOK_ADD_MODULES = " \
 
 HOOK_COPY_EXECS = " \
     mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
-    e2fsck resize2fs cryptsetup head tr rm \
+    e2fsck resize2fs cryptsetup head tr rm cmp \
     tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_startauthsession \
     tpm2_policypcr tpm2_createprimary tpm2_create tpm2_load tpm2_evictcontrol \
     tpm2_unseal tpm2_getcap tpm2_shutdown \

-- 
2.50.0


