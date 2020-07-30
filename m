Return-Path: <SRS0=QDSf=BJ=lists.cip-project.org=bounce+64572+5073+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B42EC433DF
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:39:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFD320809
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rL07k8LG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFD320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5073+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A5ixYY4521723xCKRsXdTDuv; Thu, 30 Jul 2020 02:39:21 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.4936.1596101960771964294
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 02:39:21 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 06U9d7u7006866
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2020 11:39:07 +0200
X-Received: from [167.87.91.228] ([167.87.91.228])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06U9d5U2031480;
	Thu, 30 Jul 2020 11:39:06 +0200
Subject: Re: [cip-dev] CIP Patchwork
To: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Chris.Paterson2@renesas.com, masashi.kudo@cybertrust.co.jp,
        pavel@denx.de, ben.hutchings@codethink.co.uk, SZ.Lin@moxa.com,
        wens@csie.org
References: <OSAPR01MB238534DE1045DDA72E9C7548B7760@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <OSBPR01MB29830A4698C039B05CDB23DB92710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <c6c138de-9109-9a32-59de-2cae3dffda04@siemens.com>
Date: Thu, 30 Jul 2020 11:39:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB29830A4698C039B05CDB23DB92710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by goliath.siemens.de id 06U9d7u7006866
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kyNcngK4poYgPp02vGBVHvQTx4520388AA=
Content-Type: multipart/mixed; boundary="F69a3NgMCvxZyIir3LZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596101961;
 bh=IUFENs447ySOgS8NCUpCXu0gNmwIQnqpZ0LzyqYqSNM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rL07k8LG7jBKULEVg7cWp5uoo3Q7fZjxHN05EN/m7vByXTDoN+ZZP2pdcO8DWxuK2RI
 DaDpo8rEvTMAqabfBZq3ge+wmHdA6txk2BkrVx9KKz+mtJcClQgDjqdsDhXdek5PTA+op
 xQDGGUrnOU17VaFGJ8C4IIcqlc63DJqyaNM=

--F69a3NgMCvxZyIir3LZK
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.20 11:16, Nobuhiro Iwamatsu wrote:
> Hi,
>=20
>> -----Original Message-----
>> From: Chris Paterson [mailto:Chris.Paterson2@renesas.com]
>> Sent: Thursday, July 23, 2020 6:37 PM
>> To: masashi.kudo@cybertrust.co.jp; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE=
 =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=
=EF=BC=A3=EF=BC=B4)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de; ben.hutchings@codeth=
ink.co.uk; SZ.Lin@moxa.com; wens@csie.org
>> Cc: cip-dev@lists.cip-project.org
>> Subject: CIP Patchwork
>>
>> Hello all,
>>
>> CIP has a Patchwork instance [0] that monitors the cip-dev mainline lis=
t for patches.
>>
>> It doesn't look like it's particularly maintained, with most patches in=
 the "new" state.
>> As a project, do we want to start maintaining Patchwork? Should we kill=
 it off? Or just stick with the status-quo?
>>
>> We briefly discussed this in the IRC meeting today, but I thought we sh=
ould check with a wider audience before making
>> a decision.
>=20
> Not all, I sometime checked and updated this.
> There are more non-kernel patches, so I re-check this.
> And I use this for patch tracking and patch appling.
>=20

Can we set filters based on common tags like "[isar-cip-core]" (which I=20
just forgot to use)?

Jan

>=20
>>
>> So, any thoughts?
>>
>> [0] https://patchwork.kernel.org/project/cip-dev/list/
>>
>> Kind regards, Chris
>=20
> Best regards,
>    Nobuhiro
>=20
>=20
>=20
>=20

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--F69a3NgMCvxZyIir3LZK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5073): https://lists.cip-project.org/g/cip-dev/message=
/5073
Mute This Topic: https://lists.cip-project.org/mt/75742669/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--F69a3NgMCvxZyIir3LZK--
