Return-Path: <M.tenBerge@awl.nl>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC7C1098788
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 14:18:31 +0000 (UTC)
Received: from mail.awl.nl (mail.awl.nl [37.235.118.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13843.1774016300571673603
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Mar 2026 07:18:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@awl.nl header.s=001 header.b=aeURnsRI;
 dkim=fail reason="dkim: body hash did not verify" header.i=@awl.nl header.s=selector1 header.b=f2R9KiXq;
 spf=pass (domain: awl.nl, ip: 37.235.118.135, mailfrom: m.tenberge@awl.nl)
DKIM-Signature: v=1; a=rsa-sha256; d=awl.nl; s=001; c=relaxed/relaxed;
	t=1774016297; h=from:subject:to:date:message-id;
	bh=s9WtelQtBxQoaJfj3AXJuCLM0S1wOrEQmmyDMzZPvjI=;
	b=aeURnsRInGPDmNJ9BzrKpnbFfZjwpmHyGh8AMlCKzSvxJLSpfnCDVuZtPvfhRayWtXSQ6AAVLVn
	o1PfnT9O08nwYSl/BidATbOIXW2WCvkKsSn3fE8UAeNI2DLks37A/PPiu9bh2kVfCvjTVNcB03D+R
	xVUz2ZxAosJ6zk4STk6dqoum7Xn3boj4EJDdn3RI5pGm0qQ/3kfee7urmByLaAa94xDMPIqzAqO+f
	xw1MPglQoN9Ouqryv3OtqiD8tWWztAWDXj1/7gob9++72HxrHqztP84L+GEY+2JrenbzrLGOT152q
	Xk/LS8c4OU+0/E397hDJpYlcStbU/p52w0lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awl.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nu9j9MLpVQ5A/VaLCdTPDKn7niR2L0HnO0Ygx6QkWI=;
 b=f2R9KiXq143ghFr688MxhSdwE6b8lA6/Fv8/OpO+BAT2XnyYzPHapTJ+MqmeVLUX4JVbGrvGr8qPrWv9rX+hbFsNYIQgeGBvhDhQWgO9yX+vid0PTRM1sibPAaMGZxL82uHP4As3d94ecKiXEcdI5H23CK3H6CUWCskf/1JWrV4=
From: "Berge, Matthijs ten" <M.tenBerge@awl.nl>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [isar-cip-core][RFC v1 4/7] SWUpdate: Use the
 backported package for trixie
Date: Fri, 20 Mar 2026 14:18:13 +0000
Message-ID: <DU2PR01MB8493F2CB94CB39B9C3737676E74CA@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260310044554.990348-5-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20260310044554.990348-5-Adithya.Balakumar@toshiba-tsip.com>
Content-Language: en-GB
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2026 14:18:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22517

Just a heads-up about this new version:
Our tests with this new swupdate version from Trixie-backports failed at fi=
rst. This is unrelated to the onboarding functionality mentioned in the pat=
ch below.

Building succeeded, but at runtime, an update via the command line failed w=
ith:
Unable to load key - Crypto cannot be initialized

The solution was to explicitly state the correct crypto provider for the va=
lidation of the swu signature:
swupdate -v -i updatefile.swu --digest-provider opensslCMS

Apparently, the new version contains multiple crypto providers/engines, and=
 the default choice is not compatible with the signature type used by the s=
wupdate recipes in isar-cip-core.


Best regards,

Matthijs ten Berge

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Adithya Balakumar
Sent: Tuesday, 10 March 2026 05:31
To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>; shivanand.kunij=
adar@toshiba-tsip.com; dinesh.kumar@toshiba-tsip.com; koshiro.onuki.h55@mai=
l.toshiba; kazuhiro3.hayashi@toshiba.co.jp; michael.adler@siemens.com; chri=
stian.storm@siemens.com
Subject: [cip-dev] [isar-cip-core][RFC v1 4/7] SWUpdate: Use the backported=
 package for trixie

CAUTION: This email originated from outside of the AWL organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.


From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Onboarding function requires atleast SWUpdate 2025.05, but this version is =
only available via backports in trixie

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 conf/distro/cip-core-trixie.conf              |  3 +++
 conf/distro/debian-trixie-backports.list      |  1 +
 conf/distro/preferences.trixie-backports.conf | 11 +++++++++++
 3 files changed, 15 insertions(+)
 create mode 100644 conf/distro/debian-trixie-backports.list
 create mode 100644 conf/distro/preferences.trixie-backports.conf

diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie=
.conf
index b133bbb..ad859f1 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -14,3 +14,6 @@ require cip-core-common.inc

 PREFERRED_VERSION_linux-cip ?=3D "6.12.%"
 PREFERRED_VERSION_linux-cip-rt ?=3D "6.12.%"
+
+DISTRO_APT_SOURCES:append:wfx-onboard =3D " conf/distro/debian-trixie-back=
ports.list"
+DISTRO_APT_PREFERENCES:append:wfx-onboard =3D " conf/distro/preferences.tr=
ixie-backports.conf"
diff --git a/conf/distro/debian-trixie-backports.list b/conf/distro/debian-=
trixie-backports.list
new file mode 100644
index 0000000..197bd47
--- /dev/null
+++ b/conf/distro/debian-trixie-backports.list
@@ -0,0 +1 @@
+deb http://deb.debian.org/debian trixie-backports main contrib non-free
diff --git a/conf/distro/preferences.trixie-backports.conf b/conf/distro/pr=
eferences.trixie-backports.conf
new file mode 100644
index 0000000..1a7ccdb
--- /dev/null
+++ b/conf/distro/preferences.trixie-backports.conf
@@ -0,0 +1,11 @@
+Package: swupdate
+Pin: release n=3Dtrixie-backports
+Pin-Priority: 801
+
+Package: libswupdate0.1
+Pin: release n=3Dtrixie-backports
+Pin-Priority: 801
+
+Package: libswupdate-dev
+Pin: release n=3Dtrixie-backports
+Pin-Priority: 801
--
2.39.5


AWL Disclaimer: This e-mail is intended only for the addressee(s) and conta=
ins confidential information. If you have received this e-mail in error, pl=
ease immediately notify the sender, delete the e-mail from your computer an=
d destroy all copies or print-outs (if any). This e-mail is not intended to=
 be relied upon by any person or entity without subsequent confirmation of =
its contents in the form of a (fax) letter. AWL accepts no liability for th=
e use of the information contained in this e-mail. For our full disclaimer,=
 please visit https://www.awl.nl/disclaimer/


