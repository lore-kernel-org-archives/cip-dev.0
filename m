Return-Path: <M.tenBerge@awl.nl>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A57CDB471
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 07:01:48 +0000 (UTC)
Received: from mail.awl.nl (mail.awl.nl [37.235.118.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37494.1782111698287235679
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 00:01:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@awl.nl header.s=001 header.b=KP2PPFUR;
 dkim=fail reason="dkim: body hash did not verify" header.i=@awl.nl header.s=selector1 header.b=LAs3Ovas;
 spf=pass (domain: awl.nl, ip: 37.235.118.135, mailfrom: m.tenberge@awl.nl)
DKIM-Signature: v=1; a=rsa-sha256; d=awl.nl; s=001; c=relaxed/relaxed;
	t=1782111694; h=from:subject:to:date:message-id;
	bh=UlsW7VbrQYQvvSZKnI+5TA+J+PWCYtevCjFEMg9FA38=;
	b=KP2PPFURO54CrCJAqiLZ7DxlScRFhb5T/5GctHGjtpx1pB1z8kNG1gASnWNB4CreLM4vIXG1AMx
	55eBLaNjrYx2FyeUazaSMPXA4ZAyVYgw22i2KXPY6GWy/gR/puJxgDA6hmfO+pLd5ls4PdiuujDZH
	F4lU8r64bQnXbbGU0SZ4F2/pfn1nGlPCYBqHCLlhIc1CQ0Z1iddbUzPY9cw8W+8TJk/WTYjfVlVqG
	9Ms60zKNKXRp04vehtLM7fWyIlDN+2GdmLF3jXHVQ4FcuqbZ3Dewuauw1vKrQngSCa/1W58VYYHl3
	YUKhEaknaTkOPceKEvnK4xysV66ykKDM56mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awl.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49o9j8wuppc5Q62zyZ6hb8zGFryuadjDnuTZdVwzX+I=;
 b=LAs3OvasNIQkogAcz+d5ysoMV9mbTy81haWA0Kt/uPsIVgGk6JrbhZesWweTeohj67EwQHjn7q/BH44uCroOJXeBf/gH7IwdEJdywglSK00baGUTCF8sRvBwIaBdS7eWY39lTDUgE5PoUhM86bvpPrPVlhaR6NuSIt5+y7/IwXM=
From: "Berge, Matthijs ten" <M.tenBerge@awl.nl>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [cip-dev] [isar-cip-core] Support for systemd-sysusers?
Date: Mon, 22 Jun 2026 07:01:32 +0000
Message-ID: <DU2PR01MB849335D7E2B7ECFA6C2CEA1DE7E22@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
Content-Language: nl-NL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 07:01:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23240

Hello,

The common method for a deb package to add (system) users and groups is wit=
h some commands in a .postinst script. Either directly with e.g. adduser, o=
r via a debhelper.

Last week, I encountered a source tarball that used a method that was new f=
or me: via systemd-sysusers.
A deb package can then supply a sysusers config file and drop it into /usr/=
lib/sysusers.d/*.conf. The files are merged with overrides (from /etc/sysus=
ers.d and a few other locations) by systemd, which then makes sure the requ=
ested actions are performed. It is very much comparable to the tmpfiles mec=
hanism.

The problem is: in the current cip state, these requested changes are perfo=
rmed *on first boot*. Since /etc is writeable via OverlayFS, this works, bu=
t it always results in a copy of /etc/passwd, /etc/shadow and /etc/group in=
 the upperdir. This masks future updates, so it is a nuisance.

Fortunately, systemd-sysusers also supports offline preparation of an image=
 (ideal for immutable builds).
I have added the following to my final disk image recipe (as an include fil=
e), and this seems to work correctly:


> INSTALL_systemd_sysusers +=3D "systemd-standalone-sysusers"
>
> do_systemd_sysusers[network] =3D "${TASK_USE_SUDO}"
> do_systemd_sysusers[depends] +=3D "${SCHROOT_DEP}"
>
> do_systemd_sysusers() {
>     ${SUDO_CHROOT} systemd-sysusers --root=3D"${PP_ROOTFS}"
> }
>
> addtask systemd_sysusers after do_rootfs_postprocess before do_rootfs_fin=
alize


(the systemd-standalone-sysusers package is a stripped-down version of the =
full package, with reduced dependencies.)

Two side notes:
- I've only tested with a trixie-based build.
- A specific problem which the script above didn't solve was, that the newl=
y requested user/group does not yet exist when running postinst scripts, so=
 it was not possible to 'chown' a file during deb installation into the roo=
tfs.
This can be solved by already running '/usr/bin/systemd-sysusers' (without =
any argument) from the postinst script of the package. I'm not sure if this=
 is the intended way, but it works ;-)

I'm not sure if this topic has already been discussed before on this list. =
But seeing the other thread about stable system user ids for swupdate/suric=
atta, would it be worth to consider including systemd-sysusers support in t=
he image class recipes?

Kind regards,

Matthijs ten Berge

--
development engineer
AWL-Techniek B.V.
The Netherlands
https://awl.nl
AWL Disclaimer: This e-mail is intended only for the addressee(s) and conta=
ins confidential information. If you have received this e-mail in error, pl=
ease immediately notify the sender, delete the e-mail from your computer an=
d destroy all copies or print-outs (if any). This e-mail is not intended to=
 be relied upon by any person or entity without subsequent confirmation of =
its contents in the form of a (fax) letter. AWL accepts no liability for th=
e use of the information contained in this e-mail. For our full disclaimer,=
 please visit https://www.awl.nl/disclaimer/


