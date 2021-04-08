Return-Path: <SRS0=SpJW=JF=lists.cip-project.org=bounce+64572+6347+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248A3C433B4
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 02:00:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F9D611AF
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 02:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F9D611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6347+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yycpYY4521723xfZZZoCBcTA; Wed, 07 Apr 2021 19:00:35 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.2273.1617847233012293299
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Apr 2021 19:00:34 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 13820Oaw025144; Thu, 8 Apr 2021 11:00:24 +0900
X-Iguazu-Qid: 2wHHDhxhkAHt7eILgq
X-Iguazu-QSIG: v=2; s=0; t=1617847224; q=2wHHDhxhkAHt7eILgq; m=I2bQqtPSFl3WSHirqTZM8G5NLP7+vI46mct80+gX0HM=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 13820NAT005696
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 8 Apr 2021 11:00:23 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 3623E1000D1;
	Thu,  8 Apr 2021 11:00:23 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 13820M1Q002407;
	Thu, 8 Apr 2021 11:00:22 +0900
Date: Thu, 8 Apr 2021 11:00:20 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: minmin@plathome.co.jp, pavel@denx.de, wens@csie.org,
        jan.kiszka@siemens.com
Subject: Re: [cip-dev] [Feedback Requested] RE: Cip-kernel-sec Updates for Week of 2021-03-18
X-TSB-HOP: ON
Message-ID: <20210408020020.dh6en75muwt2ouvx@toshiba.co.jp>
References: <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <bbaaff0c-aace-4c0d-2c48-00d93653416f@plathome.co.jp>
 <TY2PR01MB49725BE3622C7C3A726381A7A0689@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB49725BE3622C7C3A726381A7A0689@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RMIDQEyD6sazWJMLw19U1Zdax4520388AA=
Content-Type: multipart/mixed; boundary="9YppPcbjo6HWW07c0i39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617847235;
 bh=IWIwJO8LTxXwrYUT9qcG6kJVqt7rb1b/YpwtoVM7Df4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=T3ILndhSID3MI9mX0nUb1o/C2d9Q2Dv9uXiDm8RC8oLNqdLgsfpMpX485ykrZIrUChZ
 2HEIPTsgTUM5tXk5GFmHy/XiRZb6OrSrl5uqM7wnaf5sAnIVHUPQo7/V6Hub0Lhi6iQ2U
 1fSXxBPygsXjjUfMUKv0Kf1K3e11stwyVgc=

--9YppPcbjo6HWW07c0i39
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi all,

On Fri, Mar 19, 2021 at 04:05:32PM +0900, masashi.kudo@cybertrust.co.jp wrote:
> Hi, Mnda-san,
> 
> Thanks for your confirmation!
> 
> Iwamatsu-san,
> 
> Could you remove "plathome_obsvx1.config" itself, please?

Sure. I removed plathome_obsvx1.config from repository.

Best regards,
  Nobuhiro

> 
> Best regards,
> --
> M. Kudo
> 
> > -----Original Message-----
> > From: Masato Minda <minmin@plathome.co.jp>
> > Sent: Friday, March 19, 2021 3:56 PM
> > To: 工藤　雅司（CTJ　OSS事業推進室） <masashi.kudo@cybertrust.co.jp>;
> > cip-dev@lists.cip-project.org
> > Cc: pavel@denx.de; nobuhiro1.iwamatsu@toshiba.co.jp; wens@csie.org;
> > jan.kiszka@siemens.com
> > Subject: Re: [Feedback Requested] RE: Cip-kernel-sec Updates for Week of
> > 2021-03-18
> > 
> > Hi, Kudo-san, CIP kernel members,
> > 
> > On 2021/03/18 18:33, masashi.kudo@cybertrust.co.jp wrote:
> > > - CVE-2020-35519 is relating to X.25.
> > > X.25 is enabled as follows, but we wonder whether X.25 is really used or not.
> > >>      4.4.y-cip/x86/plathome_obsvx1.config:CONFIG_X25=m
> > 
> > Oh!
> > This configuration, "plathome_obsvx1.config" is for the OpenBlocks IoT VX1. VX1
> > is the predecessor to VX2 and we do not currently support VX1. Also, VX2 has
> > been the reference hardware for the CIP since the 4.19 kernel.
> > 
> > Therefore, I think "plathome_obsvx1.config" should be removed from the CIP
> > kernel configuration.
> > 
> > By the way, VX1 has almost the same hardware configuration as VX2, so the
> > kernel for VX2 will work as is.
> > 
> > Best Regards,
> > minmin
> > 
> > 
> > 
> 

> 
> 
> 


--9YppPcbjo6HWW07c0i39
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6347): https://lists.cip-project.org/g/cip-dev/message=
/6347
Mute This Topic: https://lists.cip-project.org/mt/81425316/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9YppPcbjo6HWW07c0i39--
