Return-Path: <M.tenBerge@awl.nl>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D017CD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 13:38:56 +0000 (UTC)
Received: from mail.awl.nl (mail.awl.nl [37.235.118.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43061.1782135531909446138
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 06:38:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@awl.nl header.s=001 header.b=nz2ezNMS;
 dkim=fail reason="dkim: body hash did not verify" header.i=@awl.nl header.s=selector1 header.b=vyVCFGek;
 spf=pass (domain: awl.nl, ip: 37.235.118.135, mailfrom: m.tenberge@awl.nl)
DKIM-Signature: v=1; a=rsa-sha256; d=awl.nl; s=001; c=relaxed/relaxed;
	t=1782135528; h=from:subject:to:date:message-id;
	bh=Ba1zswkfpv8BMo5Q3gWN5wWgPZj/VMgC82Djv5fDVlM=;
	b=nz2ezNMSRoM7hGkHJeqWzVY81aqc6t0fvlkSeUmYPcxLbc49W23nG9LRaIBy6um/+KIG2X9E8Fx
	1XYq9Cm5sId457yIgoLmdGN0ygo+bc+P2QdXW/D3Vg2Zb4sMCu78R6HNYYucng27aFngv0/NCpsj0
	FH67eLy99vZtPS5yRvnSKNdYlZS2rl7wBR1qlg22U7k1lCtMj5h0jXsM6QrcD5ZpRhPQf9fO+Ksqv
	jJyIb6KqUUe0Iqpdwa2MU3I8ytJPPuxnd42gudkZhAgV4SgBDUTVkK05sgiWxqLN6eMwNdDFXHh77
	fPzFGq8EYk0TPreh4qbQ0ZhZvkV9uGcqBqZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awl.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zsuUstkKjHdTExOEZKA5e8EkPWrMA8PfiXWMYNuaoA=;
 b=vyVCFGekVmzLD5fQoQlpMHKmzDuIUyjJ9lS42bPyByK5tYgbuDdG1MdEGdOxbCeP4wJdras6/U8iLYmSfTs+r0IVoJLtwbo3zgmPFdQjvhNktX+dDwSKYLGYK+OS4q38X75DUo00B3sIkrVs5PVTV15cop3OB4CdFDkeNJPfBAU=
From: "Berge, Matthijs ten" <M.tenBerge@awl.nl>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core] Support for systemd-sysusers?
Date: Mon, 22 Jun 2026 13:38:44 +0000
Message-ID: <DU2PR01MB84936A72F86F8EF3D9EB69E0E7EF2@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
References: <DU2PR01MB849335D7E2B7ECFA6C2CEA1DE7E22@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
 <b55e2783072d6d4cc85bbe6fbe289678868d0f43.camel@siemens.com>
In-Reply-To: <b55e2783072d6d4cc85bbe6fbe289678868d0f43.camel@siemens.com>
Content-Language: nl-NL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 13:38:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23247

MOESSBAUER, Felix <felix.moessbauer@siemens.com> wrote:
> Instead of the proposal from above, this should be implemented with
> dh_installsysusers, which also takes care of creating the user at
> package install time (untested!). Citing man dh_installsysusers
>
> > It  also  finds  the  systemd  sysusers  files  installed in a
> > package and generates relevant integration snippets for enabling the
> > users on installation.

Thanks for the pointer, I will certainly investigate dh_installsysusers fur=
ther!

> > I'm not sure if this topic has already been discussed before on this li=
st. But seeing the other thread about stable system user ids for swupdate/s=
uricatta, would it be worth to consider including systemd-sysusers support =
in the image class recipes?
>
> Now I see where you are coming from (swupdate thread) :)

Sideways;-) I've seen that thread and noticed them mentioning sysusers too.=
 We are planning for the use of SWUpdate too, so certainly relevant.
My actual use case is that I needed a newer version of NUT (network UPS too=
l) than available in Debian (and also apply a local patch for our UPS model=
), so I had to create a recipe to build from a newer tarball release from t=
hat project.
Nut upstream now already provides the sysusers config file. That's where I =
bumped my head.

> IMHO this is rather an isar topic, but the overlay part (/etc/passwd
> and alike) only affects CIP - and is already a pitfall as of today.
>
> Apart from that, Debian does not enforce stable user ids, which results
> in issues with files owned by a different user after swupdate runs.
>
> Felix

The sysusers.d manpage [1] specifies the possibility to specify UID/GID num=
bers explicitly. But if Debian packages are not using that, or are even pro=
hibited from using fixed numbers by deb policy, this can indeed become a re=
al pain, both for /etc and for /var. Thanks for the heads-up on that!
[1] https://manpages.debian.org/testing/systemd/sysusers.d.5.en.html#ID

They do specify that creating accounts should be idempotent, so not fail if=
 the accounts already exist. Unfortunately, the USERS and GROUPS are proces=
sed way too late (in do_rootfs_postprocess), so I'll probably go the route =
of trying to create the important accounts (with fixed numbers) somewhere e=
arlier in the rootfs process.

Kind regards,

Matthijs


AWL Disclaimer: This e-mail is intended only for the addressee(s) and conta=
ins confidential information. If you have received this e-mail in error, pl=
ease immediately notify the sender, delete the e-mail from your computer an=
d destroy all copies or print-outs (if any). This e-mail is not intended to=
 be relied upon by any person or entity without subsequent confirmation of =
its contents in the form of a (fax) letter. AWL accepts no liability for th=
e use of the information contained in this e-mail. For our full disclaimer,=
 please visit https://www.awl.nl/disclaimer/


