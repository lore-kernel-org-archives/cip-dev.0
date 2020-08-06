Return-Path: <SRS0=XYeN=BQ=lists.cip-project.org=bounce+64572+5105+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FF8C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  6 Aug 2020 14:26:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400482312B
	for <cip-dev@archiver.kernel.org>; Thu,  6 Aug 2020 14:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GKSN9DFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400482312B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5105+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NMYCYY4521723xOV7j7jfdMO; Thu, 06 Aug 2020 07:26:58 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.7647.1596724016016010687
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Aug 2020 07:26:57 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 076EQq1X002825
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2020 16:26:53 +0200
X-Received: from [139.22.39.76] ([139.22.39.76])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 076EQqix024411;
	Thu, 6 Aug 2020 16:26:52 +0200
Subject: Re: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add EFI_STUB to config
To: cip-dev@lists.cip-project.org, daniel.sangorrin@toshiba.co.jp,
        jan.kiszka@siemens.com
References: <20200803101217.6961-1-Quirin.Gylstorff@siemens.com>
 <OSBPR01MB298330C0C2BA66778FAB84AD92480@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Message-ID: <c0e08e23-2cc0-0ded-6266-2c4da2ccf4af@siemens.com>
Date: Thu, 6 Aug 2020 16:26:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB298330C0C2BA66778FAB84AD92480@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by lizzard.sbs.de id 076EQq1X002825
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8mp2W0Gj38AucDIjTZCl2qnax4520388AA=
Content-Type: multipart/mixed; boundary="ThnaebTjzWKY9LLUaYkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596724018;
 bh=IdwQc1GDmqDZbaigof7VuT22exL78tqP0Z6MHDOzhH8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=GKSN9DFHO7po4C/ac30CiN9Sa3GfaAL2S+BOcVdRMzBHOVnCSOZSWfRbLZEv4m9/Bu/
 WMjeM8nOBVR+HS7ILUbTXRBuY7sxRp3b1tWFhI7BwZzGbRFpe6Dbfg2HcczVQkbC9PSSH
 GZZiT8rMsBdhPaB010Cb/NT5OxAT+f8Z1uI=

--ThnaebTjzWKY9LLUaYkr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 8/6/20 8:46 AM, Nobuhiro Iwamatsu wrote:
> Hi,
>=20
> Thanks for your patch.
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.=
org] On Behalf Of Quirin Gylstorff
>> Sent: Monday, August 3, 2020 7:12 PM
>> To: cip-dev@lists.cip-project.org; sangorrin daniel(=E3=82=B5=E3=83=B3=
=E3=82=B4=E3=83=AA=E3=83=B3 =E3=83=80=E3=83=8B=E3=82=A8=E3=83=AB =E2=96=A1=
=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4)
>> <daniel.sangorrin@toshiba.co.jp>; jan.kiszka@siemens.com
>> Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> Subject: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add E=
FI_STUB to config
>>
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If EFI_STUB is not active booting QEMU with OVMF efi will fail
>> with the following error message `KVM internal error. Suberror: 3`.
>>
>> OVMF efi is used in isar-cip-core to demonstrate secure-boot with
>> a unified kernel image.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   4.19.y-cip/x86/cip_qemu_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>=20
> Please update cip_qemu.sources too.

When i try to generate the sources - all .c and asm files are no longer=20
part of the cip-qemu.sources. Did I miss something? Or should I try=20
again like the last time this happened?

>=20
> Best regards,
>    Nobuhiro
>=20
Thanks,
Quirin

--ThnaebTjzWKY9LLUaYkr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5105): https://lists.cip-project.org/g/cip-dev/message=
/5105
Mute This Topic: https://lists.cip-project.org/mt/75962579/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ThnaebTjzWKY9LLUaYkr--
