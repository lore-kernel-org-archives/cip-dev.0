Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A131C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 18:14:16 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.903.1737569649113072736
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 10:14:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fl5DvcRy;
 spf=pass (domain: gmail.com, ip: 209.85.160.48, mailfrom: stephenecker240@gmail.com)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2a01bcd0143so60264fac.2
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737569648; x=1738174448; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHoxt9gBJRzofR2mJg+sp+QMZMLEQQCRIyOQtHw8ZB4=;
        b=fl5DvcRylX0sdCCjy+r36XKWxGjBo5zEnqpZibCy6+63I25sGBb/sAY+GMHl1u73C0
         kNIkQ2L+MWpG5lVN8HRNSFxf/pe5pP7QDdlKowUF3ZDS94HtlkzLILvybbCNlkC02SSI
         RhDE+p5z8VBTF7F0FRViflB7oNz1MaxgzyL6qwSwCh1yHuLpatjukUjvLvcvw+uYueN+
         bgbfjTJ2AsOts+xhbif+cpxKrPGnPKdjjQqThVXYJxiUReu9ZEzEfzmQgnEFQhniX8iN
         BkMLkRaJOolh3NMs+PFXYkqoKmnj8tZSCzv7lK1bmLD7Cc7t63vGsUV1ELtNZxAu1meG
         PQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737569648; x=1738174448;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHoxt9gBJRzofR2mJg+sp+QMZMLEQQCRIyOQtHw8ZB4=;
        b=Za/VXxymzhwVr9V1HC2P9UcTBXV0FwsLtYQbhcYKRt93jPJijZQo+Cxj/M6GBawQrf
         bbS5zBu1VQHQYcfGRLv8kh+TL0GtCZMeGTc9O1/lyMPe6WziONZ7GW8AwDiyjUi3tgLj
         3zfv9x6U/5mu39xIQV5YciwX2W4GgXOHpliMUvXnAgP1kJScqp5qfYYs6bJ0ncRVZ+yo
         FGu/EzKMc7ovue1Lu6gCD2EVZgkNzJuDSNR8ysH9+iv0AJqwgVDgye97Yjq8YkRzA6O5
         NkRRqEKC/mNJSLJemzAeWDaNcnyAmUHfxhWc/nGWObnG7BjUjkHOH5hP+UfDOhM9LVmf
         JJHw==
X-Gm-Message-State: AOJu0YxFR/RGY3h6Vh4EGozFlXzBrQfiXdfL3oyylEiGDVbk/IgH23vf
	4Ms5gG7i7Ns+0mBMaMBvOwBvOAofdFoBScQWnLQ53n1CCkpC49ZwIA4i7M/aLpTVy4iXcc543fH
	1OA5HwkrobQ0wbzpa92hJsamNM5cYKg==
X-Gm-Gg: ASbGncsuB5dRpCvpWoMxz5jeSy+YRjkvPS+dZqN/8F873+FHiMN5p4IGD+cjgODtox4
	ZJk0SoHCMn/EC+aWP4Nbxw/0e4y1P5YoyRJbv+k5sIVsnQNBrbw==
X-Google-Smtp-Source: AGHT+IE9HvaqbJok0q41gKxQwm0+gRcUP+8SiRddCx7JbZlSD0qmGBP5heuZDvpgR0fFc7OhLGUu2uqEC2O+h9zNtvE=
X-Received: by 2002:a05:6871:20cb:b0:296:e88f:8f56 with SMTP id
 586e51a60fabf-2b1c0b512a4mr12849519fac.26.1737569648014; Wed, 22 Jan 2025
 10:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20250122142811.106525-1-alexander.heinisch@siemens.com> <6069da75-0465-4306-be32-8d5c92615c22@siemens.com>
In-Reply-To: <6069da75-0465-4306-be32-8d5c92615c22@siemens.com>
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Wed, 22 Jan 2025 12:13:55 -0600
X-Gm-Features: AbW1kvaJ_DQ2XQmnex34kfHqJBo_xMwelunt_8q3OSSKAGaxH3H9MlbBtVWoAA4
Message-ID: <CAK9C7GDRJhp=piJ3QB7DVyFCHOKbMxG2NqsmtW+oU24VvahobQ@mail.gmail.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v2] initramfs-crypt-hook:
 Optimize disk encryption in combination with expansion of last partition
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000a47ed6062c4f7590"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 18:14:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17597

--000000000000a47ed6062c4f7590
Content-Type: text/plain; charset="UTF-8"

You will have to modify the encrypt_partition.script to add btrfs support,
but it's not that difficult.  There should be a way to add support for
other filesystems with directives that provide resize commands

On Wed, Jan 22, 2025, 9:41 AM Jan Kiszka via lists.cip-project.org
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
>
> Will likely return soon: I'm playing with a/b /var using btrfs as a
> first option (should not remain the only one, but you need to start
> somewhere).
>
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
> > +             resize2fs "${last_part_mapped}"
> > +             ;;
> > +     *)
> > +             log_warning_msg "Unrecognized filesystem type ${fs_type} -
> no resize performed"
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
> Thanks, will apply (once I cleaned up my local tree from the
> ab-var-snapshot hacks).
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17596):
> https://lists.cip-project.org/g/cip-dev/message/17596
> Mute This Topic: https://lists.cip-project.org/mt/110753272/9242556
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe:
> https://lists.cip-project.org/g/cip-dev/leave/13820419/9242556/92422264/xyzzy
> [stephenecker240@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000a47ed6062c4f7590
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">You will have to modify the encrypt_partition.script to a=
dd btrfs support, but it&#39;s not that difficult.=C2=A0 There should be a =
way to add support for other filesystems with directives that provide resiz=
e commands</div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 22, 2025, 9:41 AM Jan Kiszka vi=
a <a href=3D"http://lists.cip-project.org">lists.cip-project.org</a> &lt;ja=
n.kiszka=3D<a href=3D"mailto:siemens.com@lists.cip-project.org">siemens.com=
@lists.cip-project.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">On 22.01.25 15:28, <a href=3D"mailto:alexander.heinisch@siemens.com" tar=
get=3D"_blank" rel=3D"noreferrer">alexander.heinisch@siemens.com</a> wrote:=
<br>
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
<br>
Will likely return soon: I&#39;m playing with a/b /var using btrfs as a<br>
first option (should not remain the only one, but you need to start<br>
somewhere).<br>
<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resize2fs &quot;${las=
t_part_mapped}&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_warning_msg &quot=
;Unrecognized filesystem type ${fs_type} - no resize performed&quot;<br>
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
Thanks, will apply (once I cleaned up my local tree from the<br>
ab-var-snapshot hacks).<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17596): <a href=3D"https://lists.cip-project.org/g/cip-=
dev/message/17596" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
lists.cip-project.org/g/cip-dev/message/17596</a><br>
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

--000000000000a47ed6062c4f7590--

