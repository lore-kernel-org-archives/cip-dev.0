Return-Path: <sari.sercan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B5F43682
	for <webhook@archiver.kernel.org>; Fri, 17 Apr 2026 08:49:25 +0000 (UTC)
Subject: Re: [isar-cip-core][PATCH] encrypt_partition: evict stale systemd SRK handle before enrollment
To: cip-dev@lists.cip-project.org
From: sari.sercan@siemens.com
X-Originating-Location: Vienna, AT (165.225.200.167)
X-Originating-Platform: Windows Edge 100
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 17 Apr 2026 01:49:15 -0700
References: <DB9PR10MB6643CE84D750B5014B3606DCF05DA@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM> <9171aea6-f54d-401f-8fcd-92a902b3ec16@siemens.com> <a4b214d7-4ffa-4bad-ae11-3793a1ea7a2c@siemens.com> <5166ed66-d402-4786-9b1e-bb8f7ecb13a1@siemens.com>
In-Reply-To: <5166ed66-d402-4786-9b1e-bb8f7ecb13a1@siemens.com>
Message-ID: <1451444.1776415755489458430@lists.cip-project.org>
Content-Type: multipart/alternative; boundary="mzYjT8rOxni8BGPsjlf0"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Apr 2026 08:49:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22760

--mzYjT8rOxni8BGPsjlf0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 07:03 PM, Jan Kiszka wrote:

>=20
> On 16.04.26 16:56, Quirin Gylstorff wrote:
>=20
>>=20
>>>=20
>>>> evict any stale handle before enrollment to avoid
>>>> "Failed to seal to TPM2: State not recoverable".
>>>=20
>>>=20
>>=20
>> Could you also write when this error occurs.
>=20
>=20

This occurs when systemd-cryptenroll tries to create a new primary key
at the same time the same handle is occupied. with trixie shipping systemd =
>=3D v255,
this issue is easy reproduce in consecutive installations.

>=20
> But then we would parse an error string and re-run the cryptenroll -
> does not sound very appealing this way.

By checking tpm2_getcap before evicting we can overcome this. I'll send a n=
ew version of it.

--mzYjT8rOxni8BGPsjlf0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Thu, Apr 16, 2026 at 07:03 PM, Jan Kiszka wrote:</div>
<div>
<blockquote>On 16.04.26 16:56, Quirin Gylstorff wrote:<br />
<blockquote>
<blockquote>
<blockquote>evict any stale handle before enrollment to avoid<br />"Failed =
to seal to TPM2: State not recoverable".</blockquote>
</blockquote>
Could you also write when this error occurs.</blockquote>
</blockquote>
This occurs when systemd-cryptenroll tries to create a new primary key</div=
>
<div>at the same time the same handle is occupied. with trixie shipping sys=
temd &gt;=3D v255,</div>
<div>this issue is easy reproduce in consecutive installations.</div>
<div>&nbsp;</div>
<div>
<blockquote>But then we would parse an error string and re-run the cryptenr=
oll -<br />does not sound very appealing this way.</blockquote>
</div>
<div>By checking tpm2_getcap before evicting we can overcome this. I'll sen=
d a new version of it.</div>

--mzYjT8rOxni8BGPsjlf0--

