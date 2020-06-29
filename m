Return-Path: <SRS0=yArS=AK=lists.cip-project.org=bounce+64572+4849+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61199C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:03:15 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E2B23139
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rivaEpgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E2B23139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4849+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3KviYY4521723xhS64OZRJV5; Mon, 29 Jun 2020 02:03:15 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web11.14836.1593421393876352917
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 02:03:14 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 05T93BXt008791
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 11:03:12 +0200
X-Received: from [167.87.4.33] ([167.87.4.33])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05T93BVD004113;
	Mon, 29 Jun 2020 11:03:11 +0200
Subject: Re: [cip-dev] [isar-cip-core RFC 1/4] recipes-bsp: Add efibootguard
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
 <20200625132111.16367-2-Quirin.Gylstorff@siemens.com>
 <a8fae96e-2524-7b8b-c1dc-e498162f34be@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <5a6e9d56-8eeb-3dae-7338-c9a9eff27f34@siemens.com>
Date: Mon, 29 Jun 2020 11:03:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a8fae96e-2524-7b8b-c1dc-e498162f34be@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by lizzard.sbs.de id 05T93BXt008791
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: X5JPMeYcPFhzP1mZWX0RLfOix4520388AA=
Content-Type: multipart/mixed; boundary="0NhL1sMQcdPECID7wZ9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593421395;
 bh=hNUjE7X2IA6Yk9l5lCRgi+wGr/tHgWI/GLfvQBd+83M=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rivaEpgkZEUYbZeSzw9M9Sf936lrwnSZKmeNyB6RyDpXpilZQ+4+zy7QVeAE4T7Os/H
 b1yDJ1/DzXWjXfDuCi3Ny1lyE9OiUbIjBqxFn17GCioGHdLWlYxoamt/axVnCnrMAJZ65
 DefQJOktDJIvO/EnW6iD7QLDoz2c2xA40Wo=

--0NhL1sMQcdPECID7wZ9Y
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 6/26/20 3:37 PM, Jan Kiszka wrote:
> On 25.06.20 15:21, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Add the bootloader efibootguard for A/B partition update
>> on x86 with EFI.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> =C2=A0 .../efibootguard/efibootguard_0.6-git+isar.bb |=C2=A0 46 +++++
>=20
> I just released 0.7. Maybe you could update when preparing v2.
>=20
> Jan
>=20

Sure

--0NhL1sMQcdPECID7wZ9Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4849): https://lists.cip-project.org/g/cip-dev/message=
/4849
Mute This Topic: https://lists.cip-project.org/mt/75102473/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0NhL1sMQcdPECID7wZ9Y--
