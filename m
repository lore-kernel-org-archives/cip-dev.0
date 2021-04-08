Return-Path: <SRS0=anDP=JF=lists.cip-project.org=bounce+64572+6348+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA34C433B4
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 02:08:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71934611BE
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 02:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71934611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6348+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MFmfYY4521723xgtpfy9GPyj; Wed, 07 Apr 2021 19:08:08 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.2414.1617847686647961142
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Apr 2021 19:08:08 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 138284a0020853; Thu, 8 Apr 2021 11:08:05 +0900
X-Iguazu-Qid: 34trMInxzqCVFVkZPA
X-Iguazu-QSIG: v=2; s=0; t=1617847684; q=34trMInxzqCVFVkZPA; m=CzvZDsT/96/Xa69s/JmT4VpdTuSMYicmJfA/2bCsmN4=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 138283qI004045
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 8 Apr 2021 11:08:04 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id C6AC91000CC
	for <cip-dev@lists.cip-project.org>; Thu,  8 Apr 2021 11:08:03 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 138283KM009864
	for <cip-dev@lists.cip-project.org>; Thu, 8 Apr 2021 11:08:03 +0900
Date: Thu, 8 Apr 2021 11:08:01 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH] kas: Add opt/targz-img.yml
X-TSB-HOP: ON
Message-ID: <20210408020801.h5xtgqxj2443ympl@toshiba.co.jp>
References: <20210402005346.372098-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <c51d4e05-3e17-697e-0cbd-fc504b66f0a4@siemens.com>
MIME-Version: 1.0
In-Reply-To: <c51d4e05-3e17-697e-0cbd-fc504b66f0a4@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4FNqppl1YwB6VEpBkamNGFFex4520388AA=
Content-Type: multipart/mixed; boundary="kbvGFNxwVrSA2ewoh4bd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617847688;
 bh=pWjcKZKd2zvjA1//Jw+1MCOLhwPoV3lD5nfNLTECeaQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cCEmBAXwm7L1kf1gBZtbW+tzu+JQhTXQsjV2g6zlEmIr2Gqe0nATBLJXWEr8KJ4+HOq
 Tv4fmLI2D9oBYdSYyeXvnrFoLdYM9oCvByXVKAW0m8tkcXXO58nzv3HE8HddyxO5Exm7g
 yl3PPTqUpHzcAMp8yymuS5wjbhBqI+aDr8I=

--kbvGFNxwVrSA2ewoh4bd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jan,

Thanks for your review.

On Tue, Apr 06, 2021 at 10:14:31AM +0200, Jan Kiszka wrote:
> On 02.04.21 02:53, Nobuhiro Iwamatsu wrote:
> > This provides the function to specify 'targz-img' for IMAGE_TYPE. This is
> > used when creating a tar.gz image that does not support wic.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .gitlab-ci.yml        |  3 +++
> >  kas/opt/targz-img.yml | 20 ++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >  create mode 100644 kas/opt/targz-img.yml
> > 
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index d14c72f..8802af1 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -6,6 +6,7 @@ variables:
> >    extention: base
> >    use_rt: enable
> >    wic_targz: enable
> > +  targz: disable
> >    dtb: none
> >    deploy: enable
> >  
> > @@ -30,6 +31,7 @@ default:
> >      - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
> >      - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
> >      - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
> > +    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
> >      - kas build ${base_yaml}
> >      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
> >  
> > @@ -69,6 +71,7 @@ build:qemu-amd64-base:
> >      extention: security
> >      use_rt: disable
> >      wic_targz: disable
> > +    targz: enable
> >      deploy: disable
> >  
> >  # test
> > diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
> > new file mode 100644
> > index 0000000..43c545e
> > --- /dev/null
> > +++ b/kas/opt/targz-img.yml
> > @@ -0,0 +1,20 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2019
> > +#
> > +# Authors:
> > +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +header:
> > +  version: 10
> > +
> > +# lava uses nfs to deploy the image. For this we need a tarball instead of
> > +# full image
> 
> This should rather go into the commit message as more specific reason
> why we need this patch.

OK, I will remove this sentence, and add to commit message.

> 
> > +
> > +local_conf_header:
> > +  image-type: |
> > +    IMAGE_TYPE = "targz-img"
> > 
> 
> Jan

Best regards,
  Nobuhiro

--kbvGFNxwVrSA2ewoh4bd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6348): https://lists.cip-project.org/g/cip-dev/message=
/6348
Mute This Topic: https://lists.cip-project.org/mt/81792957/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kbvGFNxwVrSA2ewoh4bd--
