Return-Path: <SRS0=jCyc=GQ=lists.cip-project.org=bounce+64572+6068+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCECC43381
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:51:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F303233CE
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F303233CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6068+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id z4KcYY4521723x6OARTDgQAv; Wed, 13 Jan 2021 04:51:50 -0800
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web09.6516.1610536193718653744
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 03:09:55 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 10DB9oFc028034
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Jan 2021 12:09:50 +0100
X-Received: from md1za8fc.ad001.siemens.net ([167.87.63.52])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10DB9on1028134;
	Wed, 13 Jan 2021 12:09:50 +0100
Date: Wed, 13 Jan 2021 12:09:49 +0100
From: Henning Schild <henning.schild@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Claudius Heine <ch@denx.de>
Cc: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] swupdate-img.bbclass: add checksum in non signed case as well
Message-ID: <20210113120949.387596fa@md1za8fc.ad001.siemens.net>
In-Reply-To: <59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
References: <20210111154856.6636-1-henning.schild@siemens.com>
	<59f30d0b-d20a-8087-4b28-5c0fd1f7853c@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FKM9stWQFORzO7t2eSVWkHlcx4520388AA=
Content-Type: multipart/mixed; boundary="TyKwlrE5k4BQ4YdsIGGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610542310;
 bh=dzlTJ62qIP760pCTLuGoANToVtKFtZQsf3WMPmU/62o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=obD0kznx+OurYkF5Qz4/qTWN5JY4GjNISWyuaHwzmconbcapGtRbYyPYmGZDpniVeO8
 VkcdXOHQX22muf9x3zxNWiqZxK9JhW2CxG0/X0H+uOzKcV90xkjv35k10sxkfbjSJ4DAW
 L6nmaSg8GIYti5rAo81uhN3qCDzcFKUw72A=

--TyKwlrE5k4BQ4YdsIGGo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 13 Jan 2021 11:46:03 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 11.01.21 16:48, Henning Schild wrote:
> > From: Claudius Heine <ch@denx.de>
> >   
> 
> Can you also provide a reasoning here?

This is taken from a layer where we use a postupdate-script as part of
an swu. The whole swu is not signed, still we want basic integrity
checking based on checksums.

My guess is that whenever you have SWU_ADDITIONAL_FILES and do not
sign, you might get a problem because of missing checksums.

But i would wait for Claudius to provide the reasoning. I guess it
should become part of the commit message in a v2.

Henning

> > Signed-off-by: Claudius Heine <ch@denx.de>
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  classes/swupdate-img.bbclass | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/classes/swupdate-img.bbclass
> > b/classes/swupdate-img.bbclass index a21d6ec..a7a70f6 100644
> > --- a/classes/swupdate-img.bbclass
> > +++ b/classes/swupdate-img.bbclass
> > @@ -39,14 +39,14 @@ do_swupdate_image() {
> >          image_do_mounts
> >          cp -f '${SIGN_KEY}' '${WORKDIR}/dev.key'
> >          test -e '${SIGN_CRT}' && cp -f '${SIGN_CRT}'
> > '${WORKDIR}/dev.crt' -
> > -        # Fill in file check sums
> > -        for file in ${SWU_ADDITIONAL_FILES}; do
> > -            sed -i "s:$file-sha256:$(sha256sum
> > '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
> > -                '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
> > -        done
> >      fi
> >  
> > +    # Fill in file check sums
> > +    for file in ${SWU_ADDITIONAL_FILES}; do
> > +        sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file
> > | cut -f 1 -d ' '):g" \
> > +            '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
> > +    done
> > +
> >      cd "${WORKDIR}/swu"
> >      for file in '${SWU_DESCRIPTION_FILE}' ${SWU_ADDITIONAL_FILES};
> > do echo "$file"
> >   
> 
> Jan
> 


--TyKwlrE5k4BQ4YdsIGGo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6068): https://lists.cip-project.org/g/cip-dev/message=
/6068
Mute This Topic: https://lists.cip-project.org/mt/79598691/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TyKwlrE5k4BQ4YdsIGGo--
