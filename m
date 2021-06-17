Return-Path: <SRS0=5V+k=LL=lists.cip-project.org=bounce+64572+6527+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE7DC2B9F4
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 09:56:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970416140F
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 09:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970416140F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6527+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id D0SUYY4521723xE6jVRJgV1J; Thu, 17 Jun 2021 02:55:59 -0700
Subject: Re: [cip-dev] [isar-cip-dev][PATCH] linux-cip-common.inc: Uprev the cip-kernel-config
To: cip-dev@lists.cip-project.org
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
X-Originating-Location: Noida, Uttar Pradesh, IN (192.94.34.34)
X-Originating-Platform: Windows Chrome 91
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 17 Jun 2021 02:55:58 -0700
References: <20210615052006.1198664-1-Srinuvasan_A@mentor.com>
In-Reply-To: <20210615052006.1198664-1-Srinuvasan_A@mentor.com>
Message-ID: <28258.1623923758706105848@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ndo4QczO7ljxoQmpcWK4z6Dfx4520388AA=
Content-Type: multipart/mixed; boundary="C1iUEfT8jHfEbamWcEqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623923759;
 bh=wp/b/k3Z7Kb7hPeZBRtdQrPNIc5O/zFDsjRW8oAwQtA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bR0F8HGbCF5gOAJK2SIaD5m5R+48iz+hj356lsoGXTGlQskJMiJrV8mKBsw5L90GubZ
 KjRkUr4HiSjwM8kZRJLPHfy73Y52l8hdSItO+lvBVT9hVOJUEdYV+CDPzJP3m2Cvn4Mr1
 T3GQtH7KDFXIQ0qNtMJOzMwwWwMxZPhdqxw=

--C1iUEfT8jHfEbamWcEqC
Content-Type: multipart/alternative; boundary="go0g2nm8yHK5cSdQKwYz"

--go0g2nm8yHK5cSdQKwYz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

It is ready for review and merge.

Thanks,
Srinuvasan.A

--go0g2nm8yHK5cSdQKwYz
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,<br />&nbsp;&nbsp;<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;It is ready for review and merge.<br /><br />Thanks,<br /=
>Srinuvasan.A<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&=
nbsp;

--go0g2nm8yHK5cSdQKwYz--

--C1iUEfT8jHfEbamWcEqC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6527): https://lists.cip-project.org/g/cip-dev/message=
/6527
Mute This Topic: https://lists.cip-project.org/mt/83525386/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--C1iUEfT8jHfEbamWcEqC--
