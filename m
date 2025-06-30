Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35738C83038
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 18:15:42 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.47806.1751307331090615015
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 11:15:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=ju/Atuyl;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1330684-20250630181525ed1fd768b8e251c5ea-rbidkz@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250630181525ed1fd768b8e251c5ea
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jun 2025 20:15:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xmJnsxhvo6ha8PGfm3uFApBMjr4WwoNcLmIahTHk/F8=;
 b=ju/AtuyljiPGOuYlvM5pBWO59AHli8r/EabcLmdC8pkNrOz+c+QeXWrPdBqEK1D3mvKo1O
 i07rGFa3UpeRkoWzKYZOnFvdAB3L6+ltcP8b0jEb79E+1B0WzX0NGs4STzYPMNxeWoWnhxSr
 QiSs8d338N66PcZ5x9m0jQcLEcxlyQfGfaCvpAyFIeVjCtv8wdQ9ksECQw/ijgeK/mJtaZ+w
 a5iCZ/LzIyWmAmaJ9oPS4xgWJIbtwWCSzbXLwGnNfBuG/qiIi17GELjXwmkQSt45mGAjz/oc
 8/KvWD3fpZwBjAeIM8rCjLhNQJDrDQYUvmOg+jY17fAzMBveDYzNBj5A==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	felix.moessbauer@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][RFC 0/7] Immutable /etc
Date: Mon, 30 Jun 2025 20:15:09 +0200
Message-Id: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 18:15:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19259

From: Alexander Heinisch <alexander.heinisch@siemens.com>

**NOTE:** The patch series appended to this RFC mainly covers
handling of /etc/machine-id (see below) in the proposed solution and serves
as a basis to estimate additional complexity ro etc introduces.
Thus, be aware that some of the patches included are not to be applied
on next, (yet), and therefore, this patchset does not cover all
cases and introduces some regression on the images built
(e.g. ssh-regen-keys)

The setup used for the PoC was built using:

```
./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/6.1.yml:kas/opt/bookworm.yml:kas/opt/ebg-swu.yml:kas/opt/readonly-etc.yml:kas/opt/machine-id-on-var.yml:kas/opt/config-on-var-demo.yml
```

## Background:

During hardening activities we identified potential
security implications of having a rw /etc.
While this most certainly is a problem when attackers gain
root access to the device, it prohibits unnoticed configuration
changes by tools running on the system, as well.

Further discussion is based on following observations:

1. Many services don't need to be reconfigured during runtime
   and shall remain static. With an (rw) overlay on /etc this cannot
   be guaranteed.

2. Having fine granular overlays won't work either, because
   some services rely on files put in /etc directly.

### Systemd:

Systemd maintainers suggest to have full /etc rw and
put immutable configuration to /usr.
While this theoretically could work, many programs
don't fall back to configuration on /usr and if so need
to be reconfigured (efforts not estimated yet).
Further potential to reconfigure services (permanently)
is still not prohibited, since in case of systemd
/etc has precedence over /usr (/lib) based configs.

## Proposal

Therefore, our RFC proposes the following:

1. Having an immutable /etc

2. In case of non-epemeral, rw-able files use soft links to /var/mutable/...
   In case attackers get (root) access, this still impacts those
   configuration but the rest remains static.

3. In case of ephemeral, rw-able files (e.g. config that can be regenerated)
   same can be applied backed by tmpfs and config service / tmpfiles.d

4. In case of rw-able dirctories fine grained overlays are ok.
   But most probably on hardened systems config tools exactly know
   which files to touch (so use can be limited quite exhaustively).

## Caveats:

While this works for most services, systemd-machine-id is one exception
which needs special treatment:

1. systemd checks for /etc/machine-id very early in the userspace init.
   Therefore, /var needs to be mounted before switching root.

   Afterwards, if /etc/machine-id (or the target in case of a link) is already
   containing a machine-id - done. Else it creates a ephemeral one and
   bindmounts it (tmpfs).

2. Later on if the filesystem providing /etc is mounted rw it persists the
   ephemeral one and "commits" it. This is not possible in case of a ro /etc.
   Therefore, I had to adapt the systemd-machine-id service to look into
   /var/mutable/etc instead


Alexander Heinisch (7):
  initramfs: Split handling of persistence mount and overlay setup.
  initramfs: Add overlay hook only if overlays are configured.
  temporary-kas: Added patches for isar upstream
  kconfig: Add option to remove /etc overlay and make /etc ro.
  Added recipe to handle persistent /etc/machine-id backed on /var.
  wks: Partial revert of 1eb0748a to populate /var partition
  Added recipe to demo a mutable config setup on /etc with ro /etc

 Kconfig                                       | 23 ++++++
 kas-cip.yml                                   |  7 ++
 kas/opt/config-on-var-demo.yml                | 17 +++++
 kas/opt/machine-id-on-var.yml                 | 17 +++++
 kas/opt/readonly-etc.yml                      | 17 +++++
 ...stproc-Enable-systemd-units-based-on.patch | 70 +++++++++++++++++++
 ...stproc-chroot-before-postprocessing-.patch | 37 ++++++++++
 .../config-on-var/config-on-var-demo.bb       | 31 ++++++++
 .../files/90-demo-app-config.conf             |  5 ++
 .../config-on-var/files/initial-config.yml    |  1 +
 .../cip-core-initramfs/cip-core-initramfs.bb  |  7 +-
 .../files/local-bottom.tmpl                   | 31 +-------
 .../initramfs-overlay-hook_0.4.bb             | 42 +++++++++++
 .../files/local-bottom.tmpl                   | 43 ++++++++++++
 .../files/persistence_recovery_action.script} |  4 +-
 .../initramfs-persistence-hook_0.1.bb}        | 29 ++++----
 .../override.conf                             |  9 +++
 .../etc/tmpfiles.d/10-mutable-machine-id.conf |  7 ++
 .../readonly-etc-support/files/postinst       | 10 +++
 .../readonly-etc-support/machine-id-on-var.bb | 37 ++++++++++
 wic/x86-uefi-efibootguard.wks.in              |  2 +-
 21 files changed, 397 insertions(+), 49 deletions(-)
 create mode 100644 kas/opt/config-on-var-demo.yml
 create mode 100644 kas/opt/machine-id-on-var.yml
 create mode 100644 kas/opt/readonly-etc.yml
 create mode 100644 patches/0001-classes-image-postproc-Enable-systemd-units-based-on.patch
 create mode 100644 patches/0001-classes-image-postproc-chroot-before-postprocessing-.patch
 create mode 100644 recipes-demo/config-on-var/config-on-var-demo.bb
 create mode 100644 recipes-demo/config-on-var/files/90-demo-app-config.conf
 create mode 100644 recipes-demo/config-on-var/files/initial-config.yml
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
 create mode 100644 recipes-initramfs/initramfs-persistent-storage/files/local-bottom.tmpl
 rename recipes-initramfs/{initramfs-overlay-hook/files/overlay_recovery_action.script => initramfs-persistent-storage/files/persistence_recovery_action.script} (64%)
 rename recipes-initramfs/{initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb => initramfs-persistent-storage/initramfs-persistence-hook_0.1.bb} (57%)
 create mode 100644 recipes-security/readonly-etc-support/files/etc/systemd/system/systemd-machine-id-commit.service.d/override.conf
 create mode 100644 recipes-security/readonly-etc-support/files/etc/tmpfiles.d/10-mutable-machine-id.conf
 create mode 100755 recipes-security/readonly-etc-support/files/postinst
 create mode 100644 recipes-security/readonly-etc-support/machine-id-on-var.bb

--
2.39.5


