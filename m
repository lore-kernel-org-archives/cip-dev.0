Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D3C02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 18:16:29 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.19731.1738779383623778097
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Feb 2025 10:16:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=M1lksq0o;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: stephenecker240@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2b199bb8af9so655614fac.1
        for <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 10:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738779382; x=1739384182; darn=lists.cip-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t2TMEfyaqLDDzB21OFt9JIrCix1hiZg82QLBIMLiVYU=;
        b=M1lksq0osE7t2rxMQaFMCmqXM+W8P2qFRFHByFLBwcAsUOtHV12BUtIEDqgzhCPymO
         MVHORKSgjKPFCCtFEjYReA7Qqiink1F6QFq6xPhSvbJLvhTFQNRYmyT08+vuJEsEQ4iD
         5H75kOP+5KY5lRIvDN//tZv2VeXeHS5TdTquB8AUo1GyUG8TKW/B+E1P21xZnH9bF/us
         pCeMkiGPPVA1rNiGgg4XFC5rf7s3H1Uzl8GD23DzX5GDv7nPJyELFQhF7Q9AQW9uJYBL
         BGnx2UKatL+OfoNV46ce+0pGzuHNfSnvnlM4NKEKQQdaR9x4RIPAGnhva6t+5BOuFrU2
         F07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738779382; x=1739384182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2TMEfyaqLDDzB21OFt9JIrCix1hiZg82QLBIMLiVYU=;
        b=u+pPAYmwWy5Yxju89j0h2ZJxyb1ZfUG/Ja9SHoih/KRiJvV+2wypZOmmMxxuMIdk5t
         pw58WTSfExHS666GRwf5u2Xn71pJBt57T0BMX5M2aCg48+cz+MhHjLxCxhM3th+QvGe2
         QPL0OTumQyNWA+6XJFr3GYT0HAh/qYl8M2nq30IDIfHJDjBXI/GTnzc2vxmJKt9VKo4g
         WDHJnZA4o5tsq1niqfG6rOUEtLMgrrMH+5ArAnygwE7UV5fh2qQUt49AqZH9ZB88wiXM
         6rE0JALg9jJt+eDHrkPkF1zqRe5W+epCfJkm31HN2MwLmQhom3y/vjKkIKx6S2NT1dbO
         Mq0Q==
X-Gm-Message-State: AOJu0YxJogwKv61fPwZ4wNcSGoxEqchZA1/0FJ5qdSkwtjDPxOilbImd
	16Y46Qc8SlKC3ttm12GoOnAk50rVREzNNv0NbAGFopzYbNeSywvQzIwPn54K+C+C0HwGkxgm8uB
	EYhkrAsCGAsy52iuZJIUA+44oSOwZcQ==
X-Gm-Gg: ASbGncsSU0367RkBkGAB0fKy2P3KE3PcleO1sTnP3osc0h9cNfCk1FiFQLTIx5iAPix
	wJcBz/JftxS/UA+wCXCeEv6hgtwIPZA/mKFzR8amaPwXSysarynqKhYwpw3JpLqwAg8MarRU=
X-Google-Smtp-Source: AGHT+IGHl2gIF20jL1yq62O8YStdy78o1+OwRvRnXyatfV5qINrvuv1i1wJnU0HFZQXS46I+35kgG1GXwjBVjwXWmO0=
X-Received: by 2002:a05:6870:7006:b0:2a7:8b78:e902 with SMTP id
 586e51a60fabf-2b81e9be830mr250165fac.7.1738779382576; Wed, 05 Feb 2025
 10:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20250122142811.106525-1-alexander.heinisch@siemens.com> <d80d4b9b-9142-4d9a-b022-b9a1f8fde0a9@siemens.com>
In-Reply-To: <d80d4b9b-9142-4d9a-b022-b9a1f8fde0a9@siemens.com>
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Wed, 5 Feb 2025 12:16:10 -0600
X-Gm-Features: AWEUYZlbECGjLPQap3M8VC6hRcX80DMXHUo1anPWYVZZ9oJ_Ajgl5WbRWarFt_A
Message-ID: <CAK9C7GCHCAds+zTM2v_ojg28fWEdL2yJUd71N7Vi6wCXci8UTQ@mail.gmail.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2] initramfs-crypt-hook:
 Optimize disk encryption in combination with expansion of last partition
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>, quirin.gylstorff@siemens.com
Content-Type: multipart/alternative; boundary="00000000000070fe16062d691fdb"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 18:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17756

--00000000000070fe16062d691fdb
Content-Type: text/plain; charset="UTF-8"

You probably do... When I did it, reencrypt wasn't needed for my scenario

On Tue, Feb 4, 2025, 7:42 AM Jan Kiszka via lists.cip-project.org
<jan.kiszka=siemens.com@lists.cip-project.org> wrote:

> On 22.01.25 15:28, alexander.heinisch@siemens.com wrote:
> > From: Alexander Heinisch <alexander.heinisch@siemens.com>
> >
> > In the current implementation (since: 284175c3) disk expansion logic
> > is done before the actual disk encryption.
> >
> > This results in reencrypting the full expanded size of the disk, instead
> > of only reencrypting the sections containing the actual data. This
> results
> > in a drastic increase of time (approx 20x on our systems ) needed for
> reencryption!
> >
> > Since relevant disk contents are only available in the sections of the
> disk
> > available before the expansion, it is sufficient to reencrypt them only.
> >
> > This patch changes order of encryption and disk expansion resulting in
> > faster encryption (since only the necessary parts are encrypted).
> > The resize operation does not reencrypt the added disk parts but just
> > extends the LUKS container (cryptsetup resize) to reflect the maximum
> > available disk space.
> >
> > Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> > ---
> >
> > Changes v2:
> > - Reuse get_fstype from mkinitramfs scripts/functions.
> >   Therefore, we could also get rid of mounting the partition
> > - Dropped support for btrfs (compared to v1) since crypt hook
> >   does not support btrfs anyways
> >
> >  .../files/local-top-complete                  | 28 ++++++++++++++++---
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git
> a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> > index 8adc4e5..0146f58 100644
> > --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> > +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> > @@ -153,6 +153,26 @@ expand_partition() {
> >       # Inform the kernel about the partitioning change
> >       partx -u "${last_part}"
> >
> > +     last_part_device_name=${last_part#\/dev/}
> > +
> > +     mapping_name=$(cat
> /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
> > +     cryptsetup resize "$mapping_name"
> > +     last_part_mapped=/dev/mapper/"$mapping_name"
> > +     fs_type=$(get_fstype ${last_part_mapped})
> > +
> > +     case ${fs_type} in
> > +     ext*)
> > +
> > +             # Do not fail resize2fs if no mtab entry is found, e.g.,
> > +             # when using systemd mount units.
> > +             export EXT2FS_NO_MTAB_OK=1
>
> Why do we need this here but not during shrinking in
> reencrypt_existing_partition?
>
> > +             resize2fs "${last_part_mapped}"
> > +             ;;
> > +     *)
> > +             log_warning_msg "Unrecognized filesystem type ${fs_type} -
> no resize performed"
>
> By now, we need support for btrfs here as well.
>
> > +             ;;
> > +     esac
> > +
> >       log_end_msg
> >  }
> >
> > @@ -215,10 +235,6 @@ for partition_set in $partition_sets; do
> >               echo "ROOT=$decrypted_part" >/conf/param.conf
> >       fi
> >
> > -     if [ "$partition_expand" = "expand" ]; then
> > -             expand_partition $part_device
> > -     fi
> > -
> >       if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
> >                       | grep -q "luks2"; then
> >               open_tpm2_partition "$part_device" "$crypt_mount_name"
> "$tpm_device"
> > @@ -259,6 +275,10 @@ for partition_set in $partition_sets; do
> >       esac
> >
> >       finalize_tpm2_encryption "$part_device"
> > +
> > +     if [ "$partition_expand" = "expand" ]; then
> > +             expand_partition $part_device
> > +     fi
> >  done
> >
> >  if [ -n "$watchdog_pid" ]; then
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17750):
> https://lists.cip-project.org/g/cip-dev/message/17750
> Mute This Topic: https://lists.cip-project.org/mt/110753272/9242556
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe:
> https://lists.cip-project.org/g/cip-dev/leave/13820419/9242556/92422264/xyzzy
> [stephenecker240@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--00000000000070fe16062d691fdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">You probably do... When I did it, reencrypt wasn&#39;t ne=
eded for my scenario</div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 4, 2025, 7:42 AM Jan =
Kiszka via <a href=3D"http://lists.cip-project.org">lists.cip-project.org</=
a> &lt;jan.kiszka=3D<a href=3D"mailto:siemens.com@lists.cip-project.org">si=
emens.com@lists.cip-project.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 22.01.25 15:28, <a href=3D"mailto:alexander.heinisch@sieme=
ns.com" target=3D"_blank" rel=3D"noreferrer">alexander.heinisch@siemens.com=
</a> wrote:<br>
&gt; From: Alexander Heinisch &lt;<a href=3D"mailto:alexander.heinisch@siem=
ens.com" target=3D"_blank" rel=3D"noreferrer">alexander.heinisch@siemens.co=
m</a>&gt;<br>
&gt; <br>
&gt; In the current implementation (since: 284175c3) disk expansion logic<b=
r>
&gt; is done before the actual disk encryption.<br>
&gt; <br>
&gt; This results in reencrypting the full expanded size of the disk, inste=
ad<br>
&gt; of only reencrypting the sections containing the actual data. This res=
ults<br>
&gt; in a drastic increase of time (approx 20x on our systems ) needed for =
reencryption!<br>
&gt; <br>
&gt; Since relevant disk contents are only available in the sections of the=
 disk<br>
&gt; available before the expansion, it is sufficient to reencrypt them onl=
y.<br>
&gt; <br>
&gt; This patch changes order of encryption and disk expansion resulting in=
<br>
&gt; faster encryption (since only the necessary parts are encrypted).<br>
&gt; The resize operation does not reencrypt the added disk parts but just<=
br>
&gt; extends the LUKS container (cryptsetup resize) to reflect the maximum<=
br>
&gt; available disk space.<br>
&gt; <br>
&gt; Signed-off-by: Alexander Heinisch &lt;<a href=3D"mailto:alexander.hein=
isch@siemens.com" target=3D"_blank" rel=3D"noreferrer">alexander.heinisch@s=
iemens.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Changes v2:<br>
&gt; - Reuse get_fstype from mkinitramfs scripts/functions. <br>
&gt;=C2=A0 =C2=A0Therefore, we could also get rid of mounting the partition=
<br>
&gt; - Dropped support for btrfs (compared to v1) since crypt hook<br>
&gt;=C2=A0 =C2=A0does not support btrfs anyways<br>
&gt; <br>
&gt;=C2=A0 .../files/local-top-complete=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 28 ++++++++++++++++---<br>
&gt;=C2=A0 1 file changed, 24 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-co=
mplete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<br=
>
&gt; index 8adc4e5..0146f58 100644<br>
&gt; --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<=
br>
&gt; +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete<=
br>
&gt; @@ -153,6 +153,26 @@ expand_partition() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0# Inform the kernel about the partitioning c=
hange<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0partx -u &quot;${last_part}&quot;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0last_part_device_name=3D${last_part#\/dev/}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mapping_name=3D$(cat /sys/class/block/&quot;$last=
_part_device_name&quot;/holders/*/dm/name)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cryptsetup resize &quot;$mapping_name&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0last_part_mapped=3D/dev/mapper/&quot;$mapping_nam=
e&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fs_type=3D$(get_fstype ${last_part_mapped})<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case ${fs_type} in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ext*)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Do not fail resize2=
fs if no mtab entry is found, e.g.,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# when using systemd =
mount units.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export EXT2FS_NO_MTAB=
_OK=3D1<br>
<br>
Why do we need this here but not during shrinking in<br>
reencrypt_existing_partition?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resize2fs &quot;${las=
t_part_mapped}&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_warning_msg &quot=
;Unrecognized filesystem type ${fs_type} - no resize performed&quot;<br>
<br>
By now, we need support for btrfs here as well.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0esac<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0log_end_msg<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -215,10 +235,6 @@ for partition_set in $partition_sets; do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;ROOT=
=3D$decrypted_part&quot; &gt;/conf/param.conf<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if [ &quot;$partition_expand&quot; =3D &quot;expa=
nd&quot; ]; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expand_partition $par=
t_device<br>
&gt; -=C2=A0 =C2=A0 =C2=A0fi<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if /usr/sbin/cryptsetup luksDump --batch-mod=
e &quot;$part_device&quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| grep -q &quot;luks2&quot;; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open_tpm2_partit=
ion &quot;$part_device&quot; &quot;$crypt_mount_name&quot; &quot;$tpm_devic=
e&quot;<br>
&gt; @@ -259,6 +275,10 @@ for partition_set in $partition_sets; do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0esac<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0finalize_tpm2_encryption &quot;$part_device&=
quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ &quot;$partition_expand&quot; =3D &quot;expa=
nd&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expand_partition $par=
t_device<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fi<br>
&gt;=C2=A0 done<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 if [ -n &quot;$watchdog_pid&quot; ]; then<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17750): <a href=3D"https://lists.cip-project.org/g/cip-=
dev/message/17750" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
lists.cip-project.org/g/cip-dev/message/17750</a><br>
Mute This Topic: <a href=3D"https://lists.cip-project.org/mt/110753272/9242=
556" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.cip-proj=
ect.org/mt/110753272/9242556</a><br>
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

--00000000000070fe16062d691fdb--

