Return-Path: <SRS0=oord=BG=lists.cip-project.org=bounce+64572+5017+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F4C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 04:59:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E141C20759
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 04:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hEKHKLD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E141C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5017+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KzRWYY4521723xtbH7CNhPJz; Sun, 26 Jul 2020 21:59:41 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.49174.1595825975517125267
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2020 21:59:37 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 06R4xXc1030075; Mon, 27 Jul 2020 13:59:33 +0900
X-Iguazu-Qid: 2wHHQAbmwvshhAObbw
X-Iguazu-QSIG: v=2; s=0; t=1595825972; q=2wHHQAbmwvshhAObbw; m=P8V98Bg4p2b33fU95eVmADZpnthdUN0aBxHmg//vbec=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1110) id 06R4xWHN019682;
	Mon, 27 Jul 2020 13:59:32 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 06R4xVBt000031
	for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 13:59:31 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 06R4xVFt016653
	for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 13:59:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7mDyr5698xVubzqJj1swDhl7pQU1D8cBZHbbW/8mR/KPVXLJP4pp7kKcHZDVU6EAIp5oFPnMmMacs6IwbmLbDhOlf5tgYyhJQIszXJ0TLvAkVuLDBUr3Kn0Fb8X0F03N9ZjUhBlobRS8JlrHMpFAzgbcr1vph2ce0G+PGfsh1WRQYEYp/zy0ospHjGfMKRMK69tZ9jaWpJR2xxr7O+u3jYjcAV+8VgayIDE6kyLt2AUjrFCbbXGBnlVJwcoGTBJFW/ygL7Y1R/yP2hB9P+3ytcSd/NdQeRfRzUB8ij9DjMqZOoFCZQC2ug2w/kGSbnBjsWv5gYVyI/hUQnxUTVojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU2jfvzrDddQQ7jnSPWRY17mSEdfJLTqJZ3bcLzhkOo=;
 b=hAHo8ThPlloRnguSoiBrNeWCJRpIpBaZQi6+/eXSVEiuTFGtpri5xKkFwrcJpsQC+tUfKOWiweZVS+yGjO2qRi/8dUJQBm4E5ouE0IfXqwgkUinOP7fGlvsGtd3OwJX8X5y7unh8sJt26VxuW8qkIoCh35As+1DallzXsbPFK+uieEBw6ylHIrKfI2n1nOWcqO5TpjUxMPKh9JKo195NytZyC/Xdlh4gUiNTnUrcMxUGQ6uSSiDoRQlHXwv94zCFyWmpJPi/9DnbUBcJQP+38ikKYm/baUXpYmD4CFMXHIDg1nkhkGqxAiso+R/GvRMz4SK5yvKWLAcl+ybqR6ujmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] [cip core] license compliance for CIP core image releases
Thread-Topic: [cip core] license compliance for CIP core image releases
Thread-Index: AdZj0WpD0VKJsyFARoKVvYqdvNCgrQ==
Date: Mon, 27 Jul 2020 04:59:29 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053E107DA782859AEE37FD3D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf532ce5-ff8b-4be1-4dc4-08d831e9d861
x-ms-traffictypediagnostic: OSAPR01MB2689:
x-microsoft-antispam-prvs: <OSAPR01MB26891198B0116AEA17138A54D0720@OSAPR01MB2689.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2LVV/psrKTPvx7ubXjmEg90/9bwPL0nmqybf7iqgZbgnlc0RDpQm/GfmkNP0GrhW5jK8wZe6+xiZQgvkDR0TRPMp2MRVDj/ONIAhRjsaqEWALPsx5cA0oc9ufNnIFxwvBKYPOmK63+N71YQ2y7KMnIILy4jBxGV2Y2EUfClQFgqd0tWX8wuevyc8ZLcR4NgkIeAgWHqSTFSZLOBzzdM7/Oh+tfwJwXOIV1Re+CgujXWnExsBi+XnQKOjud9ciT6udFZ6MoipypocVe9vzR6VMiCSKUHduX/9LjyonuY9nTJwRRqE3XKvGkRu/q6/BTfukzFRISQP6YgEHFwDWKPBTamXc/KpOcDPMlqzwDHfHZtfz9uWJtjbzzSy3mKAJfv5FVQMnBeEUrWkQx84E+jLTbSblHqwtSk7F5Du+rPGoSk1VqNZWSYrvYFaai6WujqSbwzRrQxM+ZHiF/OODvv7fg==
x-ms-exchange-antispam-messagedata: TjYH2r9kLO+ZbSLBq4ltDBrQhWwZ4qPn9X90Yw9iteLpTkvQvDGQll+2ZiDhPlJomC78dlrogQsQuPbYNL9u9ZKZJ/vi50EDehPgqQ0WJypaCsCn7OxJN6GO82R0p7Oy/265d4fsKogDRG91j2I2wjQHj11o+ugvv+1qFlqiJSJXMxMETzXBd7PpRPOBUmI30pJKYDW74srTD/pydcRBqhE5jdSJEBYW3os1JOI+wYc35Bz9JjD7/VBaZhEpaZBzpEqUG3T00buBJkspqVmkclHF+9+xLhstuygrq27OCI9ko5qRYZalFtciaARoIQ/O2UM2ppWDr/qiwjvFrOZj1C1YSgPKl+yBUv+nR6E5Vnc4VUI1FAKeCVNSIwHacn4rLzbrU0Y3h728vPRR5c35LqP6pdpajea4VE6o5CJgmlYN9NCSSM5TiDjziBql9RliyXYTNMyesI8TLK/IupvVOPBBgAaQpJbGXncTcmqG5VU=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf532ce5-ff8b-4be1-4dc4-08d831e9d861
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 04:59:29.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vk9tlsh3A1QI9xewJiHYaAhPmNJnQAsFp4UNMnefLlDn+4PDcXRJHhXMhEcOg3vXswJGle/Km3H+yKU3Xl+wiWJSCvrs1Mm37fccY9x3L1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2689
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: os95Zd7UGQv3L1oP7kAU2eTex4520388AA=
Content-Type: multipart/mixed; boundary="QPm5Jgnsvm648pZTl23W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595825981;
 bh=hj0bO6FqztjXR1GGoT72KJvUohzTpsb/QB7O30k5SvM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hEKHKLD5P4lf2Bje9Vi99/E8WF5lA9xPbhaJ1CG9MWcbeafPIRhgg4J2yh3gui2DRSh
 G+PYDYbJO+TH3hiQ2+1+5J/oS6VmmgmVIepYmzXUOtBLXq1T3lgj3U4JDtqqyIPcldrHe
 J26xnvxmdhE8wtnu6e/1iYPJbZ41eBZ86Lk=

--QPm5Jgnsvm648pZTl23W
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello,

During the last CIP Core meeting we discussed about license compliance for =
CIP core image releases.
In particular, we talked about how to make sure that users can get exactly =
the same source code version used to build the Debian binary packages inclu=
ded on each image.

We concluded that we should not rely on Debian repositories, but rather cre=
ate our own apt mirror with snapshots for each release.

However, today I asked myself: when people upload a Docker image to Dockerh=
ub, what do they do to comply with the licenses of all of the packages insi=
de.

I thought that Microsoft would be one of the most cautious and checked thei=
r Docker images.

https://hub.docker.com/_/microsoft-dotnet-core (click "Discover licensing f=
or Linux image contents")=20

If you read their document, it looks like the rely on the Debian source cod=
e packages to be always available either in the Debian repo or the Snapshot=
s repository.

[Note] additionally they rely on the license and copyright information prov=
ided by Debian to be correct (they do not verify it manually)

I would like to know your opinions about this. Do you think it is worth the=
 effort to build, pay and maintain a repository mirror with snapshots? or c=
an we rely on Debian snapshot repositories (for users to retrieve source co=
de, not for building the image)?

Thanks,
Daniel
=20



--QPm5Jgnsvm648pZTl23W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5017): https://lists.cip-project.org/g/cip-dev/message=
/5017
Mute This Topic: https://lists.cip-project.org/mt/75816703/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QPm5Jgnsvm648pZTl23W--
