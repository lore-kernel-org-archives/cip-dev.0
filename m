Return-Path: <SRS0=B78l=EZ=lists.cip-project.org=bounce+64572+5810+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9FEC2D0E4
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 07:42:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B175A2085B
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 07:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Z3jopGix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B175A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5810+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xlEYYY4521723xwDMReyGBj2; Wed, 18 Nov 2020 23:42:44 -0800
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.6000.1605771763787484945
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2020 23:42:44 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 0AJ7gUZo031942
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2020 08:42:30 +0100
X-Received: from [167.87.38.29] ([167.87.38.29])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AJ7gS9i000484;
	Thu, 19 Nov 2020 08:42:29 +0100
Subject: Re: [cip-dev] About corresponding CVE-2020-25669 from CIP kernel config side
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, wens@csie.org, pavel@denx.de,
        masashi.kudo@cybertrust.co.jp
References: <OSBPR01MB29831AC14AD65ADE956DFF3392E00@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <41fcecae-8dff-ca7c-1b07-2f8469ca7eba@siemens.com>
Date: Thu, 19 Nov 2020 08:42:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB29831AC14AD65ADE956DFF3392E00@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Wx4fPolHeXTkjVdSzskQpKu1x4520388AA=
Content-Type: multipart/mixed; boundary="mAFXLdPQHrr3arEgbciV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605771764;
 bh=A4UYOT+OuQz0xX63Ckwh3G15PKcZ9NIsROfcdu7kfNA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Z3jopGixjIBQSH+ydrVskf4+mrJzunxoerVSU6CbJi/8dDTnFPaU14PZMVaZxV5dnUj
 GlYwnpaVgbUFM6CIWPqQ3/dyfXtBKc2XN7THXX1WtjpkaXIf91k2ikC/KhTxK6jDC76EP
 3QTLTOl+HpY0yxa0hwLoRJ21JjqIWtajcm0=

--mAFXLdPQHrr3arEgbciV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 19.11.20 03:43, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Jan,
> 
> CVE-2020-25669[0] is a CVE for SUNKBD (sun4/sun5 keyboard), which is
> enabled in siemens_i386-rt kernel.
> 
> ```
> $ git grep SUNKBD
> 4.19.y-cip-rt/x86/siemens_i386-rt.config:# CONFIG_KEYBOARD_SUNKBD is not set
> 4.19.y-cip/x86/plathome_obsvx2.config:# CONFIG_KEYBOARD_SUNKBD is not set
> 4.19.y-cip/x86/siemens_iot2000.config:# CONFIG_KEYBOARD_SUNKBD is not set
> 4.4.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_KEYBOARD_SUNKBD=m
> 4.4.y-cip/arm/siemens_am57xx-pxm3.config:# CONFIG_KEYBOARD_SUNKBD is not set
> 4.4.y-cip/arm/siemens_imx6_defconfig:# CONFIG_KEYBOARD_SUNKBD is not set
> 4.4.y-cip/x86/plathome_obsvx1.config:# CONFIG_KEYBOARD_SUNKBD is not set
> 4.4.y-cip/x86/siemens_iot2000.config:# CONFIG_KEYBOARD_SUNKBD is not set
> ```
> 
> Is this driver used? If you're not using it, I'd consider removing it from the kernel's
> config to support this CVE. Could you give me your opinion on this?
> 

Drop the config switch and ignore the issue - this was very likely an
"over-configuration" due to being derived from some distro config.

Thanks,
Jan

> 
> Best regards,
>   Nobuhiro
> 
> [0]: https://security-tracker.debian.org/tracker/CVE-2020-25669
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--mAFXLdPQHrr3arEgbciV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5810): https://lists.cip-project.org/g/cip-dev/message=
/5810
Mute This Topic: https://lists.cip-project.org/mt/78357177/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mAFXLdPQHrr3arEgbciV--
