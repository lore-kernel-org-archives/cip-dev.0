Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8105DC19776
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 00:47:15 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web10.419.1740617229947189970
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 16:47:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LtAO2p/4;
 spf=pass (domain: gmail.com, ip: 209.85.167.177, mailfrom: stephenecker240@gmail.com)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3ff03c89dso197828b6e.2
        for <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 16:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740617229; x=1741222029; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGSquzGDZWIWr3djv8HzQ/yA3CDNS5Z6g6MAc6/Pzac=;
        b=LtAO2p/4ucs0qj8AZwdxeuMqWYpne2Ub62LP6IG1lYBS5ZNcmlGtKuo0JDid2q2FW5
         nbOb4K1tuNpWZJVZlNsetLXVp8VO3aBZDvcj+X464ih9TOz2erFaz1sZ/TNq2ll2Osl0
         BrMw0pBQ7/xa+uIJ203vIsdM0QJ7V83Rg4++84MfBCST4iL8wmjCwBYQuPybnTK3ilO2
         W6RnHTL7gXyQqEwIfyzVISaUfCXjW5PH4RsFJ3TRT+nD4R0C9RyV2xMj9+YAuq4fLFN4
         GfsEczV1bfr41zuUqY/hzDhc5P2N6ySSLQ2WObNz8xxUKOkzfLN1IUmgOukNfw6rsGWm
         /HCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740617229; x=1741222029;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGSquzGDZWIWr3djv8HzQ/yA3CDNS5Z6g6MAc6/Pzac=;
        b=uxeuM0cD+96gfWcJKYsZPwxYFHognY8WYxZ4ds1p/DgnKphUGoafv5Nz4iErUF7DQX
         IYL+T3oAZ7p2TDcBgsUt2JdCKvQGL9dYJmmM70ByLNsbzyo8XZPZ/fgEjUYqUhYOZSF/
         apdXoLuABdSw9atXeFOa2KfBm377QDuxd/JLv/rYynoCDTEm449fRFvNFuuN7kC09avI
         QLnAX286LNPveUHDdAnvFr8nvNWGZeDSOMnJ6FziI5tJQh5RXuWyHSdZwc16fjRmFfBH
         l6hAlu07JuYuR25sUij07p8aTJSrV2Ut/sQtUOFK3+4OA/jaqPy4j7DWq0Lp6vtQR+GQ
         mKew==
X-Gm-Message-State: AOJu0YzvkHW8i//213CrMcIhNpK3dWU1IoYfT9aPciCYnSTykdL9ksG1
	YueJOg73t+wq/HLcGTBeHLSai0DP8bAEpp9eHuiINYs+eoRlVT/zX7xJiUzIhkxk4IZJjZGDhNr
	F1y0m3KVyhLpTN+odMt/nKgD59d5NSw==
X-Gm-Gg: ASbGncvPUhQv2lVH6h5I2GeYJlcFQHod7YmFq1NjvprU7EPsYGODj8IaznizzHCiGSp
	hAWNvkboIBe8lDtaiM/xS/8J/oX/TerODo9UY7ZBkRFwh6rktAJrWtkwkWyeYjTQkvZQl+uKRJZ
	THLg1W2pw+fo/oWEboNZqV5j/kNlvZNQRSz3kP4Qg=
X-Google-Smtp-Source: AGHT+IFDhnc6Ntll4r+wdBsZ+U5vhlOzeT/z1PZRcEQ2g654+ZYh3ZtzxhYBxLgP2r3B42ltWJ6SIxeI09PdeW/H7xs=
X-Received: by 2002:a05:6808:3c8e:b0:3f3:fb4e:f5b0 with SMTP id
 5614622812f47-3f540ec2222mr6999163b6e.9.1740617228940; Wed, 26 Feb 2025
 16:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20250226232812.374892-1-alexander.heinisch@siemens.com>
In-Reply-To: <20250226232812.374892-1-alexander.heinisch@siemens.com>
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Wed, 26 Feb 2025 18:46:58 -0600
X-Gm-Features: AQ5f1JpNO_iwG2xqV3s3sExw2e6AiVi8OjWKKLKfBw8tKRFoPy1NJnlV1FmT_wc
Message-ID: <CAK9C7GBj+Ovxx9GqS842OMqzKC7Yfn--6=yQMc8mnDHxMrt38A@mail.gmail.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3] initramfs-crypt-hook:
 Optimize disk encryption in combination with expansion of last partition
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="0000000000009efe19062f1507ec"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 00:47:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17925

--0000000000009efe19062f1507ec
Content-Type: text/plain; charset="UTF-8"

Is that right?  I presumed it was encrypting the entire disk, not just
partitions on the disk.

On Wed, Feb 26, 2025, 5:28 PM Heinisch, Alexander via lists.cip-project.org
<alexander.heinisch=siemens.com@lists.cip-project.org> wrote:

> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>
> In the current implementation (since: 284175c3) disk expansion logic
> is done before the actual disk encryption.
>
> This results in reencrypting the full expanded size of the disk, instead
> of only reencrypting the sections containing the actual data. This results
> in a drastic increase of time (approx 20x on our systems ) needed for
> reencryption!
>
> Since relevant disk contents are only available in the sections of the disk
> available before the expansion, it is sufficient to reencrypt them only.
>
> This patch changes order of encryption and disk expansion resulting in
> faster encryption (since only the necessary parts are encrypted).
> The resize operation does not reencrypt the added disk parts but just
> extends the LUKS container (cryptsetup resize) to reflect the maximum
> available disk space.
>
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>
> Changes v3:
> - Provide key to cryptsetup resize for clevis based setups.
> - removed export of EXT2FS_NO_MTAB_OK=1
> - Added support to expand partitions with btrfs
>
> Changes v2:
> - Reuse get_fstype from mkinitramfs scripts/functions.
>   Therefore, we could also get rid of mounting the partition
> - Dropped support for btrfs (compared to v1) since crypt hook
>   does not support btrfs anyways
>
>  .../files/local-top-complete                  | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)
>
> diff --git
> a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 5ef7ca4..fac6db6 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -102,6 +102,8 @@ reencrypt_existing_partition() {
>  }
>
>  expand_partition() {
> +       key_file="$2"
> +
>         boot_device="$(echo "${part_device}" | sed 's/p\?[0-9]*$//')"
>         last_part="$(sfdisk -d "${boot_device}" 2>/dev/null | \
>                      tail -1 | cut -d ' ' -f 1)"
> @@ -155,6 +157,33 @@ expand_partition() {
>         # Inform the kernel about the partitioning change
>         partx -u "${last_part}"
>
> +       last_part_device_name=${last_part#\/dev/}
> +
> +       mapping_name=$(cat
> /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
> +       # systemd based systems do not need to have the
> +       # key_file provided since systemd backend for
> +       # cryptsetup resolves the passphrase directly
> +       cat $key_file | cryptsetup resize "$mapping_name"
> +
> +       last_part_mapped=/dev/mapper/"$mapping_name"
> +       fs_type=$(get_fstype ${last_part_mapped})
> +
> +       case ${fs_type} in
> +       ext*)
> +               resize2fs "${last_part_mapped}"
> +               ;;
> +       btrfs)
> +               mkdir /.mnt-tmp
> +               mount -t btrfs "${last_part_mapped}" /.mnt-tmp
> +               btrfs filesystem resize max /.mnt-tmp
> +               umount /.mnt-tmp
> +               rmdir /.mnt-tmp
> +               ;;
> +       *)
> +               log_warning_msg "Unrecognized filesystem type ${fs_type} -
> no resize performed"
> +               ;;
> +       esac
> +
>         log_end_msg
>  }
>
> @@ -217,10 +246,6 @@ for partition_set in $partition_sets; do
>                 echo "ROOT=$decrypted_part" >/conf/param.conf
>         fi
>
> -       if [ "$partition_expand" = "expand" ]; then
> -               expand_partition $part_device
> -       fi
> -
>         if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>                         | grep -q "luks2"; then
>                 open_tpm2_partition "$part_device" "$crypt_mount_name"
> "$tpm_device"
> @@ -260,6 +285,10 @@ for partition_set in $partition_sets; do
>                  ;;
>         esac
>
> +       if [ "$partition_expand" = "expand" ]; then
> +               expand_partition $part_device $tmp_key
> +       fi
> +
>         finalize_tpm2_encryption "$part_device"
>  done
>
> --
> 2.43.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17924):
> https://lists.cip-project.org/g/cip-dev/message/17924
> Mute This Topic: https://lists.cip-project.org/mt/111406562/9242556
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe:
> https://lists.cip-project.org/g/cip-dev/leave/13820419/9242556/92422264/xyzzy
> [stephenecker240@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000009efe19062f1507ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Is that right?=C2=A0 I presumed it was encrypting the ent=
ire disk, not just partitions on the disk.=C2=A0=C2=A0</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Feb 26, 2025, 5:28 PM Heinisch, Alexander via <a href=3D"http://l=
ists.cip-project.org">lists.cip-project.org</a> &lt;alexander.heinisch=3D<a=
 href=3D"mailto:siemens.com@lists.cip-project.org">siemens.com@lists.cip-pr=
oject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Al=
exander Heinisch &lt;<a href=3D"mailto:alexander.heinisch@siemens.com" targ=
et=3D"_blank" rel=3D"noreferrer">alexander.heinisch@siemens.com</a>&gt;<br>
<br>
In the current implementation (since: 284175c3) disk expansion logic<br>
is done before the actual disk encryption.<br>
<br>
This results in reencrypting the full expanded size of the disk, instead<br=
>
of only reencrypting the sections containing the actual data. This results<=
br>
in a drastic increase of time (approx 20x on our systems ) needed for reenc=
ryption!<br>
<br>
Since relevant disk contents are only available in the sections of the disk=
<br>
available before the expansion, it is sufficient to reencrypt them only.<br=
>
<br>
This patch changes order of encryption and disk expansion resulting in<br>
faster encryption (since only the necessary parts are encrypted).<br>
The resize operation does not reencrypt the added disk parts but just<br>
extends the LUKS container (cryptsetup resize) to reflect the maximum<br>
available disk space.<br>
<br>
Signed-off-by: Alexander Heinisch &lt;<a href=3D"mailto:alexander.heinisch@=
siemens.com" target=3D"_blank" rel=3D"noreferrer">alexander.heinisch@siemen=
s.com</a>&gt;<br>
---<br>
<br>
Changes v3:<br>
- Provide key to cryptsetup resize for clevis based setups.<br>
- removed export of EXT2FS_NO_MTAB_OK=3D1<br>
- Added support to expand partitions with btrfs<br>
<br>
Changes v2:<br>
- Reuse get_fstype from mkinitramfs scripts/functions. <br>
=C2=A0 Therefore, we could also get rid of mounting the partition<br>
- Dropped support for btrfs (compared to v1) since crypt hook<br>
=C2=A0 does not support btrfs anyways<br>
<br>
=C2=A0.../files/local-top-complete=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 37 +++++++++++++++++--<br>
=C2=A01 file changed, 33 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<br>
index 5ef7ca4..fac6db6 100644<br>
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<br>
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<br>
@@ -102,6 +102,8 @@ reencrypt_existing_partition() {<br>
=C2=A0}<br>
<br>
=C2=A0expand_partition() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0key_file=3D&quot;$2&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 boot_device=3D&quot;$(echo &quot;${part_device}=
&quot; | sed &#39;s/p\?[0-9]*$//&#39;)&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 last_part=3D&quot;$(sfdisk -d &quot;${boot_devi=
ce}&quot; 2&gt;/dev/null | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tail -1 | cut -d &#39; &#39; -f 1)&quot;<br>
@@ -155,6 +157,33 @@ expand_partition() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Inform the kernel about the partitioning chan=
ge<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 partx -u &quot;${last_part}&quot;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0last_part_device_name=3D${last_part#\/dev/}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mapping_name=3D$(cat /sys/class/block/&quot;$la=
st_part_device_name&quot;/holders/*/dm/name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# systemd based systems do not need to have the=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# key_file provided since systemd backend for <=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# cryptsetup resolves the passphrase directly<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cat $key_file | cryptsetup resize &quot;$mappin=
g_name&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0last_part_mapped=3D/dev/mapper/&quot;$mapping_n=
ame&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fs_type=3D$(get_fstype ${last_part_mapped})<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case ${fs_type} in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ext*)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resize2fs &quot;${l=
ast_part_mapped}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir /.mnt-tmp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mount -t btrfs &quo=
t;${last_part_mapped}&quot; /.mnt-tmp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs filesystem re=
size max /.mnt-tmp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0umount /.mnt-tmp<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir /.mnt-tmp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_warning_msg &qu=
ot;Unrecognized filesystem type ${fs_type} - no resize performed&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0esac<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_end_msg<br>
=C2=A0}<br>
<br>
@@ -217,10 +246,6 @@ for partition_set in $partition_sets; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;ROOT=3D$=
decrypted_part&quot; &gt;/conf/param.conf<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;$partition_expand&quot; =3D &quot;ex=
pand&quot; ]; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expand_partition $p=
art_device<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if /usr/sbin/cryptsetup luksDump --batch-mode &=
quot;$part_device&quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | grep -q &quot;luks2&quot;; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open_tpm2_partition=
 &quot;$part_device&quot; &quot;$crypt_mount_name&quot; &quot;$tpm_device&q=
uot;<br>
@@ -260,6 +285,10 @@ for partition_set in $partition_sets; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 esac<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ &quot;$partition_expand&quot; =3D &quot;ex=
pand&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expand_partition $p=
art_device $tmp_key<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 finalize_tpm2_encryption &quot;$part_device&quo=
t;<br>
=C2=A0done<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17924): <a href=3D"https://lists.cip-project.org/g/cip-=
dev/message/17924" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
lists.cip-project.org/g/cip-dev/message/17924</a><br>
Mute This Topic: <a href=3D"https://lists.cip-project.org/mt/111406562/9242=
556" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.cip-proj=
ect.org/mt/111406562/9242556</a><br>
Group Owner: <a href=3D"mailto:cip-dev%2Bowner@lists.cip-project.org" targe=
t=3D"_blank" rel=3D"noreferrer">cip-dev+owner@lists.cip-project.org</a><br>
Unsubscribe: <a href=3D"https://lists.cip-project.org/g/cip-dev/leave/13820=
419/9242556/92422264/xyzzy" rel=3D"noreferrer noreferrer" target=3D"_blank"=
>https://lists.cip-project.org/g/cip-dev/leave/13820419/9242556/92422264/xy=
zzy</a> [<a href=3D"mailto:stephenecker240@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">stephenecker240@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000009efe19062f1507ec--

