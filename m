Return-Path: <SRS0=FeH/=B4=lists.cip-project.org=bounce+64572+5132+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B0DC433E1
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 13:56:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1082620738
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="V6e+54un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1082620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5132+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zARsYY4521723xxz82w5gzqD; Tue, 18 Aug 2020 06:56:02 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.66775.1597758960355466879
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 06:56:01 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 07IDtvOn011970
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2020 15:55:57 +0200
X-Received: from [167.87.130.66] ([167.87.130.66])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07IDts6i003127;
	Tue, 18 Aug 2020 15:55:55 +0200
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add recipe
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <16281511DE955BB5.19258@lists.cip-project.org>
 <OSBPR01MB298327233BFADC291456E190925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <b2289205-5f7e-9f57-ba0a-496a4c8749b3@siemens.com>
 <OSBPR01MB2983367B30C868D82CA6B7AE925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <e525e738-22ee-ce33-e515-23614bf82837@siemens.com>
Date: Tue, 18 Aug 2020 15:55:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983367B30C868D82CA6B7AE925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by lizzard.sbs.de id 07IDtvOn011970
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Y0CrFhWtMubt7kqBtO61k4Wxx4520388AA=
Content-Type: multipart/mixed; boundary="WU29m6AWOj3vzj1qQA8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597758962;
 bh=Nswm9F0NBXjCxQtbiCZqyHzcpzBA8GvLWCLVnTpDPFg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=V6e+54unyb0fUpLKt74Uv+CKL0vu75cLlI1J9mv26pyVKqvSNKjVVG6UZ3FPBa9C15/
 /GjYIUMqMCdDr9myEuUdJ4klkcvIgPLYXeGZm0y6qjSKXZVv5Woer1BycyO+b+XnDYxsL
 eMj3K/7zELBby1oUvMDQZKYIujKSLSJzOZg=

--WU29m6AWOj3vzj1qQA8A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.08.20 15:47, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka@siemens.com]
>> Sent: Tuesday, August 18, 2020 2:30 PM
>> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE=
 =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=
=EF=BC=A3=EF=BC=B4) <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test:=
 Add recipe
>>
>> On 18.08.20 06:57, Nobuhiro Iwamatsu wrote:
>>> Hi Jan,
>>>
>>> Could you comment on this patch series?
>>>
>>
>> Ah, yeah, sorry.
>>
>> I think now it's better to model that as extension of an image, given
>> that we already have two (regular + security). Or will we implicitly
>> test the security image via the regular one?
>>
>=20
> I see.
> When extended, the resulting image will have the same filename as the b=
ase.
> It's difficult to distinguish, so it's implemented as it is now.
> If you know how to change the generated image file name by yaml file, p=
lease let me know.

Isar does not yet allow to override the image name. You'd basically have
to weaken its setting like this

[isar/meta/classes/image.bbclass]
IMAGE_FULLNAME ?=3D "${PN}-${DISTRO}-${MACHINE}"

and then you could override IMAGE_FULLNAME as desired.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--WU29m6AWOj3vzj1qQA8A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5132): https://lists.cip-project.org/g/cip-dev/message=
/5132
Mute This Topic: https://lists.cip-project.org/mt/75987091/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--WU29m6AWOj3vzj1qQA8A--
