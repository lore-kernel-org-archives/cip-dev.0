Return-Path: <SRS0=eTgt=AK=lists.cip-project.org=bounce+64572+4848+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F1C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:01:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DD723142
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="h07abeSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DD723142
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4848+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id miRvYY4521723x8iYgbmwJcR; Mon, 29 Jun 2020 02:01:37 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.14742.1593421296415892054
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 02:01:37 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 05T91YPQ010112
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 11:01:34 +0200
X-Received: from [167.87.4.33] ([167.87.4.33])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05T91WaO001763;
	Mon, 29 Jun 2020 11:01:33 +0200
Subject: Re: [cip-dev] [isar-cip-core RFC 6/7] swupdate: Add luahandler for secureboot
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
 <20200625141015.31719-7-Quirin.Gylstorff@siemens.com>
 <7e9f03be-1cc3-48be-98bf-c0b8b1692c7a@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <81a7b2f1-c80a-9397-92e2-44b6e0d8e500@siemens.com>
Date: Mon, 29 Jun 2020 11:01:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7e9f03be-1cc3-48be-98bf-c0b8b1692c7a@siemens.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id 05T91YPQ010112
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RG50yXZWm6eyXrVj366geYmJx4520388AA=
Content-Type: multipart/mixed; boundary="DtDUWgH4f7L1dGz2fXk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593421297;
 bh=1VM4bUA2u45Jp/7yCbMuqA9fWttF7dRimB1UP3eL/Ck=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=h07abeSb26NVpGtnE7ZaANwqMOxUo55cNYDr/RX99Hy2BR5eDC0UH/NGqlLWoCeEBJT
 zuKK6dZ1wcinbUOMV8bTadaD+ZWRmbF51kwUmFa6mOJrpiPRFSNBfeRqqdJZVSyg2DNSV
 fMtcAt2m9xm1fK7Tw/qkb9FEyn//8sI5764=

--DtDUWgH4f7L1dGz2fXk2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 6/29/20 10:14 AM, Jan Kiszka wrote:
> On 25.06.20 16:10, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> =C2=A0 recipes-core/swupdate/files/swupdate_handlers.lua | 8 ++++++--
>> =C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-core/swupdate/files/swupdate_handlers.lua=20
>> b/recipes-core/swupdate/files/swupdate_handlers.lua
>> index c9b9962..f2ecc54 100644
>> --- a/recipes-core/swupdate/files/swupdate_handlers.lua
>> +++ b/recipes-core/swupdate/files/swupdate_handlers.lua
>> @@ -311,8 +311,12 @@ function handler_roundrobin(image)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if rootparam an=
d rootdevice then break end
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not rootdevice then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swupdate.error("Cannot determine curre=
nt root device.")
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Use findmnt to get the =
rootdev
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootdevice =3D io.popen('findmnt -nl /=
 -o PARTUUID'):read("*l")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not rootdevice then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swupdate.error("Cannot det=
ermine current root device.")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swupdate.info(string.format("Current ro=
ot device is: %s",=20
>> rootdevice))
>>
>=20
> Seems not really specific to secure-boot, rather related to the=20
> initramfs-based rootfs selection. But is that one actually using=20
> PARTUUID in the end? Or rather device paths?

it uses the partuuid from root. If someone finds a better way to get
the current root without parsing the  kernel commandline I would use
that.
>=20
> Anyway, I'm not against merging this. It should just be correctly=20
> labeled. Or maybe even merged into the swupdate patch from the first=20
> series.

I move the patch to the a/b update patch.

>=20
> Jan
>=20

--=20
Quirin

--DtDUWgH4f7L1dGz2fXk2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4848): https://lists.cip-project.org/g/cip-dev/message=
/4848
Mute This Topic: https://lists.cip-project.org/mt/75103454/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DtDUWgH4f7L1dGz2fXk2--
