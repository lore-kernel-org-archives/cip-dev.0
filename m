Return-Path: <SRS0=F4hG=O2=lists.cip-project.org=bounce+64572+6793+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB74C433FE
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 16:12:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB55610E5
	for <cip-dev@archiver.kernel.org>; Wed,  6 Oct 2021 16:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCB55610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=coolautomation.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A703YY4521723xAo8Ug2XmUI; Wed, 06 Oct 2021 09:12:38 -0700
X-Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web09.14529.1633536757542875497
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 09:12:37 -0700
X-Received: by mail-wr1-f42.google.com with SMTP id u18so10457776wrg.5
        for <cip-dev@lists.cip-project.org>; Wed, 06 Oct 2021 09:12:37 -0700 (PDT)
X-Gm-Message-State: Yw3IgJij3xQHFuwE0RqqOhC0x4520388AA=
X-Google-Smtp-Source: ABdhPJw35YJDdE9QjU/yGOaiM/9I+BgZZ3G5+1WkpPNaAVwKA0bkPTpgEZEcAGfaDFwDwL2vj0R04w==
X-Received: by 2002:a05:600c:2057:: with SMTP id p23mr9462424wmg.67.1633536755592;
        Wed, 06 Oct 2021 09:12:35 -0700 (PDT)
X-Received: from cool (bzq-84-110-33-210.static-ip.bezeqint.net. [84.110.33.210])
        by smtp.gmail.com with ESMTPSA id l11sm8065461wms.45.2021.10.06.09.12.34
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:12:35 -0700 (PDT)
Date: Wed, 6 Oct 2021 19:12:33 +0300
From: "Sergey Nazaryev" <sergey@coolautomation.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Deby project status?
Message-ID: <20211006161233.ehdsr7n34dvr66rq@cool>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="LFUqoETwpmQjWzDIMfoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633536758;
 bh=uZLCU7rPKt0EoJEBP4D4LNDsILqdSHZ39V3NY8Zoqjg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=P9u8J2GbIA5TS3ytQLbINvqG57m+bBNbXWIQWFLwFvdH2BEl/LqLJjSTYUBQCgF7t9L
 TxnqnOv9HnuhPxkdAdHcCkVqYI+znFkyrHhUxztGr5RpxKPPLm0iQ0GpeBCIG9ze3znIn
 Qf0oL3GpEMHO25K1sGvtVDcF01frYiXDpuk=
Message-ID: <20211006161233.bgbK1v3eGETEWrZAv-aA6oWEIoIlzO-jl9OL-34fg-w@z>

--LFUqoETwpmQjWzDIMfoT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

Recently I've found the Deby project and I consider it as a candidate
for using on our new device.

However, as I can see, there is no activity in this project:

- last commit in cip-core/deby was in April
- it builds with errors
- there are no updates in Deby section of CIP core meetings reports
- all issues related to Deby (e.g. swupdate support) weren't updated
  since last year

It seems like a bad sign. Are all efforts aimed to isar-cip-core?

Anyway, is there any plans to develop Deby (or any other distro under
the aegis of CIP project for devices with storage restrictions) in
future?

Thank you in advance.

Best regards,
Sergey Nazaryev

--LFUqoETwpmQjWzDIMfoT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6793): https://lists.cip-project.org/g/cip-dev/message/=
6793
Mute This Topic: https://lists.cip-project.org/mt/86123752/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LFUqoETwpmQjWzDIMfoT--
