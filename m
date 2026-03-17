Return-Path: <M.tenBerge@awl.nl>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7C8F33808
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 07:22:28 +0000 (UTC)
Received: from mail.awl.nl (mail.awl.nl [37.235.118.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70837.1773732137694794030
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 00:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@awl.nl header.s=001 header.b=Yoe0l7dG;
 dkim=fail reason="dkim: body hash did not verify" header.i=@awl.nl header.s=selector1 header.b=qPIom659;
 spf=pass (domain: awl.nl, ip: 37.235.118.135, mailfrom: m.tenberge@awl.nl)
DKIM-Signature: v=1; a=rsa-sha256; d=awl.nl; s=001; c=relaxed/relaxed;
	t=1773732134; h=from:subject:to:date:message-id;
	bh=BdMbNbKFBmpVZv2/cc0KKecgl5Zed1ctzcY7PeH22kU=;
	b=Yoe0l7dGpetdDtAFxcC39f/gUY9Mf8BH66Ad+2RNF6Qk8c7HxXV7zWCzTu5bS2B/7apc18Deet1
	yLjFe/CeXTmRpoJw1tNOaKVmASZo7PdQOHUeCVwg/6LtoxW+afOk8kbRM7pF/ZzmbcyrCu6kx5SvR
	mQPvRcfzUb3+8oYNmwbWnHCGTfm2rck2Qi/JHkwcAvIPb7nl7peHoNnIJjtWjCj2P5hfdSH/zxZD1
	sQms+2Kt3cn2zLim5mi8AR2GqWI5lclDsh/Kb75HyJlSKaczGLNU1PJreUPZsmxZgt5FSGCj/pTW2
	qCQ6GxahqFVhC0GpYB+jaaaJ9Zuw68/o+9Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awl.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDLHoZOcYQ3DZ8iSnXMoaOAdfThzUaQhDFfi0oIJI/g=;
 b=qPIom659CrfpWihnVyhYLZ7xOBwep0OQegj3i0DZPWYU0jMercuA7JA9GGIC3iM1nQc5IzkW26hHe2uk/IQTpgAa6/hk/q1WcQdNVcjPxzXagmna/1S0YsBMbO0n48hvGy7w/PAmk4g821R0UfJEAg4ffFQ2dglNt+zDKPELfNw=
From: "Berge, Matthijs ten" <M.tenBerge@awl.nl>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] typo in pam security customizations
Date: Tue, 17 Mar 2026 07:22:09 +0000
Message-ID: <DU2PR01MB8493DC648C797E2B7514B19DE741A@DU2PR01MB8493.eurprd01.prod.exchangelabs.com>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 07:22:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22430

RGVhciBtYWludGFpbmVycywNCg0KTGluZSA0MiBvZiByZWNpcGVzLWNvcmUvc2VjdXJpdHktY3Vz
dG9taXphdGlvbnMvZmlsZXMvcG9zdGluc3QgY29udGFpbnMgYSBzdHJheSAiLnNvIiBhZnRlciBw
YW1fZmFpbGxvY2suc28sIHdoaWNoIGNhdXNlcyB0aGUgZm9sbG93aW5nIHN5c2xvZyBlcnJvciBt
ZXNzYWdlIHdoZW4gZG9pbmcgYSBjb25zb2xlIGxvZ2luOg0KDQpsb2dpblsuLi5dOiBwYW1fZmFp
bGxvY2sobG9naW46YXV0aCk6IFVua25vd24gb3B0aW9uOiAuc28NCg0KaHR0cHM6Ly9naXRsYWIu
Y29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9ibG9iL25leHQvcmVjaXBl
cy1jb3JlL3NlY3VyaXR5LWN1c3RvbWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0P3JlZl90eXBlPWhl
YWRzI0w0Mg0KDQooU29ycnkgSSBjYW4ndCB1c2UgZ2l0IGVtYWlsIHBhdGNoIGZvcm1hdCB5ZXQp
DQoNCktpbmQgcmVnYXJkcywNCg0KTWF0dGhpanMgdGVuIEJlcmdlDQpBV0wgRGlzY2xhaW1lcjog
VGhpcyBlLW1haWwgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIGFkZHJlc3NlZShzKSBhbmQgY29u
dGFpbnMgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlz
IGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyLCBk
ZWxldGUgdGhlIGUtbWFpbCBmcm9tIHlvdXIgY29tcHV0ZXIgYW5kIGRlc3Ryb3kgYWxsIGNvcGll
cyBvciBwcmludC1vdXRzIChpZiBhbnkpLiBUaGlzIGUtbWFpbCBpcyBub3QgaW50ZW5kZWQgdG8g
YmUgcmVsaWVkIHVwb24gYnkgYW55IHBlcnNvbiBvciBlbnRpdHkgd2l0aG91dCBzdWJzZXF1ZW50
IGNvbmZpcm1hdGlvbiBvZiBpdHMgY29udGVudHMgaW4gdGhlIGZvcm0gb2YgYSAoZmF4KSBsZXR0
ZXIuIEFXTCBhY2NlcHRzIG5vIGxpYWJpbGl0eSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5mb3JtYXRp
b24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsLiBGb3Igb3VyIGZ1bGwgZGlzY2xhaW1lciwgcGxl
YXNlIHZpc2l0IGh0dHBzOi8vd3d3LmF3bC5ubC9kaXNjbGFpbWVyLw0KDQo=

