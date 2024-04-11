Return-Path: <hannah.kiekens@essensium.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F62C4345F
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 15:09:17 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web11.20562.1712848152259745323
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Apr 2024 08:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@essensium.com header.s=google header.b=DIplPQ8W;
 spf=pass (domain: essensium.com, ip: 209.85.160.174, mailfrom: hannah.kiekens@essensium.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4367e9f6b38so535591cf.1
        for <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google; t=1712848151; x=1713452951; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j0Tx5oF5GVgK0VyTi74QxpNiJFQ29trG9UO72CHhF8Q=;
        b=DIplPQ8WSEsBzjfcen6PBV3ryVUWVqx6ocjzaIPWJAJPLnY/5/3f1SNcw6nJ4pTukF
         nrFUJcYxaNfYHdjb7XsVfk8KMUkJ9uRIIVQ+uVNr2I+54cgoSEweSxtbG7KSsG9wrZdy
         2vSC04DeaDikt7vbQBkxXDuq4pkRz/ItfkmpMrwTNy2WUXoFEbVcomSmwcWdkagfHqNF
         xi+9XBNReX0wtq5en8Gr5ATnKz+ipQgJpbFAjaYydE3ekuySBntvFll5mH7PG7CRzLtk
         fPueQ1zXHaUtpUfXiYWEDEENmizE73rbE1q4ZlMPBUSI8lx2WlhC6WJDOns+48oKFwqA
         rX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848151; x=1713452951;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0Tx5oF5GVgK0VyTi74QxpNiJFQ29trG9UO72CHhF8Q=;
        b=UWQ5ZedX/QfbWM1VbaWWmF5B8m1qKqpfuxFNTmGbxANOwed8Bu4GxuFqRRL6dvj6W1
         scc6mm3tkJMkkh3o/DXJpSFo9+MU4yX52haOFvyDj3MQxONdm0dqRDff3xLwxGu5/MzS
         cO/b08QKWkIObIrDhdy/BrY6wfzObDlolXCuSaJ5VIDmyJgcRS9ZO1EwbHKAvUM3jKQv
         O6lmJ6bFi43SsXEC77bvkDorhyi+qX7QUsXgLL1abP4zKZVxPANg8peL/APnV3xkSlXg
         BG84Da4Pj2PoL6AK3r3LZJyAMQVndb0G4lNPpLxKP5HYpOuK7QB/uS+QZ+/E3DvnPoo0
         rSDQ==
X-Gm-Message-State: AOJu0Yyq3ex2cj7drlAzWrNwvrzdl4uoizwv4ZjFDsvvCcZdfoPPRCHS
	V0b8utIm8Hnzs9R0cMRWmmgkSdHINNynzf4VcYDbfhCRtf+9puJJOzH9QGA1s5gFX/dzc/PNfob
	NyCibFvhywP4oLOX0e2ioOyXPkVSAi7a9igwUgbVQZJra0mgXzsdMQg==
X-Google-Smtp-Source: AGHT+IGl/YIySfYK2KwnoINI7pr+5jAlRAVlF+B15XrUAw/SWEif34Ro/kOP0fnCGKEG+4YDkMeXuTCzxyYEbUMQ0m4=
X-Received: by 2002:a05:622a:586:b0:434:5c51:e8de with SMTP id
 c6-20020a05622a058600b004345c51e8demr6480080qtb.32.1712848150870; Thu, 11 Apr
 2024 08:09:10 -0700 (PDT)
MIME-Version: 1.0
From: Hannah Kiekens <hannah.kiekens@essensium.com>
Date: Thu, 11 Apr 2024 17:09:00 +0200
Message-ID: <CAP07BnkpBLJ0vnN3FUJZp+DDiWm8wjj5F3=wMNfabqjPJvMDDQ@mail.gmail.com>
Subject: Bookworm with swupdate 2021.11: Error getting key 'kernelfile' from
 bootloader environment.
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="0000000000009663230615d389b2"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 15:09:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15545

--0000000000009663230615d389b2
Content-Type: text/plain; charset="UTF-8"

Hi everyone!

The roundrobin handler seems broken for the bookworm with swupdate 2021.11
combination.
It is easy to reproduce with qemu on the next branch,
PREFERRED_VERSION_swupdate = "2021.11%" is the only change that's needed.
Log of this setup included at the end of the e-mail

I am not seeing anything that's obviously different with bullseye.
We are using bullseye with swupdate 2021.11 on tag v1.3. I am working on an
upgrade path to bookworm

Regards,
Hannah

LOG:
root@demo:~# swupdate -v -i cip-core-image-cip-core-bookworm-qemu-amd64.swu
[TRACE] : SWUPDATE running :  [swupdate_dgst_init] : public key / cert
/usr/share/swupdate-signing/swupdate-sign.crt ignored, you need to set
SIGALG
Swupdate v2021.11.0

Licensed under GPLv2. See source distribution for detailed copyright
notices.

[INFO ] : SWUPDATE running :  [lua_handlers_init] : Lua handler(s) found.
[INFO ] : SWUPDATE running :  [main] : Running on cip-qemu-amd64 Revision
cip-core-1.0
[INFO ] : SWUPDATE running :  [print_registered_handlers] : Registered
handlers:
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     dummy
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     archive
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     tar
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     uboot
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     bootloader
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     uniqueuuid
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     lua
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     raw
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     rawfile
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     rawcopy
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     rdiff_image
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     rdiff_file
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     readback
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     shellscript
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     preinstall
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     postinstall
[INFO ] : SWUPDATE running :  [print_registered_handlers] :     roundrobin
[TRACE] : SWUPDATE running :  [network_initializer] : Main loop daemon
[TRACE] : SWUPDATE running :  [listener_create] : got no socket at
/tmp/swupdateprog from systemd
[TRACE] : SWUPDATE running :  [listener_create] : creating socket at
/tmp/swupdateprog
[TRACE] : SWUPDATE running :  [listener_create] : got no socket at
/tmp/sockinstctrl from systemd
[TRACE] : SWUPDATE running :  [listener_create] : creating socket at
/tmp/sockinstctrl
[TRACE] : SWUPDATE running :  [network_thread] : Incoming network request:
processing...
[INFO ] : SWUPDATE started :  Software Update started !
[TRACE] : SWUPDATE running :  [network_initializer] : Software update
started
[TRACE] : SWUPDATE running :  [extract_file_to_tmp] : Found file
[TRACE] : SWUPDATE running :  [extract_file_to_tmp] :   filename
sw-description
[TRACE] : SWUPDATE running :  [extract_file_to_tmp] :   size 1267
[TRACE] : SWUPDATE running :  [get_common_fields] : Version 0.2
[TRACE] : SWUPDATE running :  [parse_hw_compatibility] : Accepted Hw
Revision : cip-core-1.0
[TRACE] : SWUPDATE running :  [add_properties] : Found properties for
linux.efi:
[TRACE] : SWUPDATE running :  [add_properties_cb] :             Property
subtype: kernel
[TRACE] : SWUPDATE running :  [_parse_files] : Found File: linux.efi -->
linux.efi (C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1)
[TRACE] : SWUPDATE running :  [add_properties] : Found properties for
cip-core-image-cip-core-bookworm-qemu-amd64.squashfs:
[TRACE] : SWUPDATE running :  [add_properties_cb] :             Property
subtype: image
[TRACE] : SWUPDATE running :  [add_properties_cb] :             Property
configfilecheck: /etc/os-release@not_match
@IMAGE_UUID=7f15735e-dd28-48b3-a881-a2e7353d93df
[TRACE] : SWUPDATE running :  [_parse_images] : Found Image:
cip-core-image-cip-core-bookworm-qemu-amd64.squashfs in device :
C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002
for handler roundrobin
[TRACE] : SWUPDATE running :  [check_hw_compatibility] : Hardware
cip-qemu-amd64 Revision: cip-core-1.0
[TRACE] : SWUPDATE running :  [check_hw_compatibility] : Hardware
compatibility verified
[TRACE] : SWUPDATE running :  [extract_files] : Found file
[TRACE] : SWUPDATE running :  [extract_files] :         filename
sw-description.sig
[TRACE] : SWUPDATE running :  [extract_files] :         size 1348 Not
required: skipping
[TRACE] : SWUPDATE running :  [extract_files] : Found file
[TRACE] : SWUPDATE running :  [extract_files] :         filename
cip-core-image-cip-core-bookworm-qemu-amd64.squashfs
[TRACE] : SWUPDATE running :  [extract_files] :         size 119066624
required
[TRACE] : SWUPDATE running :  [extract_files] : Found file
[TRACE] : SWUPDATE running :  [extract_files] :         filename linux.efi
[TRACE] : SWUPDATE running :  [extract_files] :         size 16962560
required
[TRACE] : SWUPDATE running :  [extract_padding] : Expecting 388 padding
bytes at end-of-file
[TRACE] : SWUPDATE running :  [network_initializer] : Valid image found:
copying to FLASH
[INFO ] : SWUPDATE running :  Installation in progress
[TRACE] : SWUPDATE running :  [install_single_image] : Found installer for
stream cip-core-image-cip-core-bookworm-qemu-amd64.squashfs roundrobin
[TRACE] : SWUPDATE running :  [notify_helper] : Round Robin Handler: No
compiled-in config found, trying /etc/swupdate.handler.ini
[ERROR] : SWUPDATE failed [0] ERROR : Round Robin Handler: Error getting
key 'kernelfile' from bootloader environment.
[ERROR] : SWUPDATE failed [0] ERROR : Round Robin Handler: Could not
determine current root device.
[TRACE] : SWUPDATE running :  [l_handler_wrapper] : [Lua handler] returned:
1
[TRACE] : SWUPDATE running :  [install_single_image] : Installer for
roundrobin not successful !
[ERROR] : SWUPDATE failed [1] Installation failed !
[TRACE] : SWUPDATE running :  [network_initializer] : Main thread sleep
again !
[INFO ] : No SWUPDATE running :  Waiting for requests...
[INFO ] : SWUPDATE running :  [endupdate] : Swupdate *failed* !

--0000000000009663230615d389b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi everyone!</div><div><br></div><div>The roundrobin =
handler seems broken for the bookworm with swupdate 2021.11 combination.</d=
iv><div>It is easy to reproduce with qemu on the next branch, PREFERRED_VER=
SION_swupdate =3D &quot;2021.11%&quot; is the only change that&#39;s needed=
. Log of this setup included at the end of the e-mail<br></div><div><br></d=
iv><div>I am not seeing anything that&#39;s obviously different with bullse=
ye.=C2=A0</div><div>We are using bullseye with swupdate 2021.11 on tag v1.3=
. I am working on an upgrade path to bookworm</div><div><br></div><div>Rega=
rds,</div><div>Hannah<br></div><div><br>LOG:</div><div>root@demo:~# swupdat=
e -v -i cip-core-image-cip-core-bookworm-qemu-amd64.swu <br>[TRACE] : SWUPD=
ATE running : =C2=A0[swupdate_dgst_init] : public key / cert /usr/share/swu=
pdate-signing/swupdate-sign.crt ignored, you need to set SIGALG<br>Swupdate=
 v2021.11.0<br><br>Licensed under GPLv2. See source distribution for detail=
ed copyright notices.<br><br>[INFO ] : SWUPDATE running : =C2=A0[lua_handle=
rs_init] : Lua handler(s) found.<br>[INFO ] : SWUPDATE running : =C2=A0[mai=
n] : Running on cip-qemu-amd64 Revision cip-core-1.0<br>[INFO ] : SWUPDATE =
running : =C2=A0[print_registered_handlers] : Registered handlers:<br>[INFO=
 ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =C2=A0 d=
ummy<br>[INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =
=C2=A0 =C2=A0 archive<br>[INFO ] : SWUPDATE running : =C2=A0[print_register=
ed_handlers] : =C2=A0 =C2=A0 tar<br>[INFO ] : SWUPDATE running : =C2=A0[pri=
nt_registered_handlers] : =C2=A0 =C2=A0 uboot<br>[INFO ] : SWUPDATE running=
 : =C2=A0[print_registered_handlers] : =C2=A0 =C2=A0 bootloader<br>[INFO ] =
: SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =C2=A0 uniq=
ueuuid<br>[INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =
=C2=A0 =C2=A0 lua<br>[INFO ] : SWUPDATE running : =C2=A0[print_registered_h=
andlers] : =C2=A0 =C2=A0 raw<br>[INFO ] : SWUPDATE running : =C2=A0[print_r=
egistered_handlers] : =C2=A0 =C2=A0 rawfile<br>[INFO ] : SWUPDATE running :=
 =C2=A0[print_registered_handlers] : =C2=A0 =C2=A0 rawcopy<br>[INFO ] : SWU=
PDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =C2=A0 rdiff_ima=
ge<br>[INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=
=A0 =C2=A0 rdiff_file<br>[INFO ] : SWUPDATE running : =C2=A0[print_register=
ed_handlers] : =C2=A0 =C2=A0 readback<br>[INFO ] : SWUPDATE running : =C2=
=A0[print_registered_handlers] : =C2=A0 =C2=A0 shellscript<br>[INFO ] : SWU=
PDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =C2=A0 preinstal=
l<br>[INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=
=A0 =C2=A0 postinstall<br>[INFO ] : SWUPDATE running : =C2=A0[print_registe=
red_handlers] : =C2=A0 =C2=A0 roundrobin<br>[TRACE] : SWUPDATE running : =
=C2=A0[network_initializer] : Main loop daemon<br>[TRACE] : SWUPDATE runnin=
g : =C2=A0[listener_create] : got no socket at /tmp/swupdateprog from syste=
md<br>[TRACE] : SWUPDATE running : =C2=A0[listener_create] : creating socke=
t at /tmp/swupdateprog<br>[TRACE] : SWUPDATE running : =C2=A0[listener_crea=
te] : got no socket at /tmp/sockinstctrl from systemd<br>[TRACE] : SWUPDATE=
 running : =C2=A0[listener_create] : creating socket at /tmp/sockinstctrl<b=
r>[TRACE] : SWUPDATE running : =C2=A0[network_thread] : Incoming network re=
quest: processing...<br>[INFO ] : SWUPDATE started : =C2=A0Software Update =
started !<br>[TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Sof=
tware update started<br>[TRACE] : SWUPDATE running : =C2=A0[extract_file_to=
_tmp] : Found file<br>[TRACE] : SWUPDATE running : =C2=A0[extract_file_to_t=
mp] : =C2=A0 filename sw-description<br>[TRACE] : SWUPDATE running : =C2=A0=
[extract_file_to_tmp] : =C2=A0 size 1267<br>[TRACE] : SWUPDATE running : =
=C2=A0[get_common_fields] : Version 0.2<br>[TRACE] : SWUPDATE running : =C2=
=A0[parse_hw_compatibility] : Accepted Hw Revision : cip-core-1.0<br>[TRACE=
] : SWUPDATE running : =C2=A0[add_properties] : Found properties for linux.=
efi:<br>[TRACE] : SWUPDATE running : =C2=A0[add_properties_cb] : =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Property subtype: kernel<br>[TRACE] : SWUPD=
ATE running : =C2=A0[_parse_files] : Found File: linux.efi --&gt; linux.efi=
 (C:BOOT0:linux.efi-&gt;BOOT0,C:BOOT1:linux.efi-&gt;BOOT1)<br>[TRACE] : SWU=
PDATE running : =C2=A0[add_properties] : Found properties for cip-core-imag=
e-cip-core-bookworm-qemu-amd64.squashfs:<br>[TRACE] : SWUPDATE running : =
=C2=A0[add_properties_cb] : =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Prope=
rty subtype: image<br>[TRACE] : SWUPDATE running : =C2=A0[add_properties_cb=
] : =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Property configfilecheck: /et=
c/os-release@not_match@IMAGE_UUID=3D7f15735e-dd28-48b3-a881-a2e7353d93df<br=
>[TRACE] : SWUPDATE running : =C2=A0[_parse_images] : Found Image: cip-core=
-image-cip-core-bookworm-qemu-amd64.squashfs in device : C:BOOT0:linux.efi-=
&gt;fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi-&gt;fedcba98-765=
4-3210-cafe-5e0710000002 for handler roundrobin<br>[TRACE] : SWUPDATE runni=
ng : =C2=A0[check_hw_compatibility] : Hardware cip-qemu-amd64 Revision: cip=
-core-1.0<br>[TRACE] : SWUPDATE running : =C2=A0[check_hw_compatibility] : =
Hardware compatibility verified<br>[TRACE] : SWUPDATE running : =C2=A0[extr=
act_files] : Found file<br>[TRACE] : SWUPDATE running : =C2=A0[extract_file=
s] : =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename sw-description.sig<br>[TRACE] : S=
WUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =
1348 Not required: skipping<br>[TRACE] : SWUPDATE running : =C2=A0[extract_=
files] : Found file<br>[TRACE] : SWUPDATE running : =C2=A0[extract_files] :=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename cip-core-image-cip-core-bookworm-qemu=
-amd64.squashfs<br>[TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 size 119066624 required<br>[TRACE] : SWUPDATE runn=
ing : =C2=A0[extract_files] : Found file<br>[TRACE] : SWUPDATE running : =
=C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0 =C2=A0 filename linux.efi<br>[=
TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size 16962560 required<br>[TRACE] : SWUPDATE running : =C2=A0[extrac=
t_padding] : Expecting 388 padding bytes at end-of-file<br>[TRACE] : SWUPDA=
TE running : =C2=A0[network_initializer] : Valid image found: copying to FL=
ASH<br>[INFO ] : SWUPDATE running : =C2=A0Installation in progress<br>[TRAC=
E] : SWUPDATE running : =C2=A0[install_single_image] : Found installer for =
stream cip-core-image-cip-core-bookworm-qemu-amd64.squashfs roundrobin<br>[=
TRACE] : SWUPDATE running : =C2=A0[notify_helper] : Round Robin Handler: No=
 compiled-in config found, trying /etc/swupdate.handler.ini<br>[ERROR] : SW=
UPDATE failed [0] ERROR : Round Robin Handler: Error getting key &#39;kerne=
lfile&#39; from bootloader environment.<br>[ERROR] : SWUPDATE failed [0] ER=
ROR : Round Robin Handler: Could not determine current root device.<br>[TRA=
CE] : SWUPDATE running : =C2=A0[l_handler_wrapper] : [Lua handler] returned=
: 1<br>[TRACE] : SWUPDATE running : =C2=A0[install_single_image] : Installe=
r for roundrobin not successful !<br>[ERROR] : SWUPDATE failed [1] Installa=
tion failed !<br>[TRACE] : SWUPDATE running : =C2=A0[network_initializer] :=
 Main thread sleep again !<br>[INFO ] : No SWUPDATE running : =C2=A0Waiting=
 for requests...<br>[INFO ] : SWUPDATE running : =C2=A0[endupdate] : Swupda=
te *failed* !<br><br><br></div></div>

--0000000000009663230615d389b2--

