Return-Path: <SRS0=Y+xz=LL=lists.cip-project.org=bounce+64572+6531+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515EDC2B9F4
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 11:06:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED2561026
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 11:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED2561026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6531+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XIWpYY4521723xpgNhreR9TH; Thu, 17 Jun 2021 04:06:50 -0700
Subject: Re: [cip-dev] Request support to switch the CIP version
To: cip-dev@lists.cip-project.org
From: "Vijai Kumar K" <vijaikumar.kanagarajan@gmail.com>
X-Originating-Location: US (139.181.30.34)
X-Originating-Platform: Windows Chrome 91
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 17 Jun 2021 04:06:49 -0700
References: <CAMbjpb_3E0-528zAOnKQRTBQTf+xf4vptPOtQLmBWKptgbvkQw@mail.gmail.com>
In-Reply-To: <CAMbjpb_3E0-528zAOnKQRTBQTf+xf4vptPOtQLmBWKptgbvkQw@mail.gmail.com>
Message-ID: <561.1623928009865341440@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sWVUrK7tdSzHL0npIOVMfIimx4520388AA=
Content-Type: multipart/mixed; boundary="zIgDHZPGZOyVr6918grU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623928010;
 bh=7fYfmh0hb3pEAKDeu3Tr9wHiWj/i1vI0jlPXKZm0Gqw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=OB6P4JFftLyqsmEYmmiie7pm7B6uMaFh3kdXAox57ULLB8w0Qgn6oEni0smKZ85vY6U
 pwO4SyJezONKabwdW6lW/2+ec01FnhcPEY6WCKoKn3hW4Ra+LS06Y2aCbla2ZYieNqTxl
 X2q9ajr4yRPO9c03CJ8aKZCY0/NIbV4YAog=

--zIgDHZPGZOyVr6918grU
Content-Type: multipart/alternative; boundary="h2v089SjNsElI6Pb06o1"

--h2v089SjNsElI6Pb06o1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2021 at 04:25 PM, Lakshmi Natarajan <lakshmi.natarajan@sanm=
ina.com> wrote:

>=20
> 4.19.186

Hi Lakshmi,

I generally download and compute the sha256 sum and update it in the recip=
e.

This is the SHA256 I get.
79ddff697e644dd7545cd3d20f8f540d7cced52d283aad924adda262247684c7=C2=A0 lin=
ux-cip-v4.19.186-cip47.tar.gz

If you have the right sha, then probably the download failed.

Thanks,
Vijai Kumar K

--h2v089SjNsElI6Pb06o1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2021 at 04:25 PM, Lakshmi Natarajan &lt;lakshmi.natarajan@s=
anmina.com&gt; wrote:<br />
<blockquote>4.19.186</blockquote>
Hi Lakshmi,<br /><br />I generally download and compute the sha256 sum and=
 update it in the recipe.<br /><br />This is the SHA256 I get.<br />79ddff6=
97e644dd7545cd3d20f8f540d7cced52d283aad924adda262247684c7&nbsp; linux-cip-v=
4.19.186-cip47.tar.gz<br /><br />If you have the right sha, then probably t=
he download failed.<br /><br />Thanks,<br />Vijai Kumar K

--h2v089SjNsElI6Pb06o1--

--zIgDHZPGZOyVr6918grU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6531): https://lists.cip-project.org/g/cip-dev/message=
/6531
Mute This Topic: https://lists.cip-project.org/mt/83601368/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zIgDHZPGZOyVr6918grU--
