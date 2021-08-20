Return-Path: <SRS0=LCBQ=NL=lists.cip-project.org=bounce+64572+6702+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C3C4338F
	for <cip-dev@archiver.kernel.org>; Fri, 20 Aug 2021 06:20:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED6161042
	for <cip-dev@archiver.kernel.org>; Fri, 20 Aug 2021 06:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6ED6161042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zIbuYY4521723xlExWPbXnGT; Thu, 19 Aug 2021 23:20:38 -0700
Subject: Re: [cip-dev] [isar-cip-dev][PATCH] Uprevision the cip-kernel-config to latest one
To: cip-dev@lists.cip-project.org
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
X-Originating-Location: Noida, Uttar Pradesh, IN (192.94.34.34)
X-Originating-Platform: Windows Chrome 92
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 19 Aug 2021 23:20:37 -0700
References: <20210810072040.716025-1-Srinuvasan_A@mentor.com>
In-Reply-To: <20210810072040.716025-1-Srinuvasan_A@mentor.com>
Message-ID: <22873.1629440437567993857@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3VwZC8Y8PuA3aLFPjGDTXAAwx4520388AA=
Content-Type: multipart/mixed; boundary="3SNPHJ2QkyrgcvtxA1c2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629440438;
 bh=YOzou62YEXOrgD/XBuMmeg1XwaD9M2t5xSvnLSJdPGk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=orevcBusx7ULYI+vuiQRVy2oJWrZEqe+/yhq+B6aL1NyA84Uof+5D8l1pGwYP0w7Fbo
 55X0KeN7/MaaPhfSpDx4g5kU1BSptqdj4oTqyfH7Mr4nHmV0fF5BYFvckH0Gc40gBknvV
 3OFtS7GqO337kfLbYj/w/V5MxLjiN5en1fk=

--3SNPHJ2QkyrgcvtxA1c2
Content-Type: multipart/alternative; boundary="jQYCLmEXCTXcS8CGYtCk"

--jQYCLmEXCTXcS8CGYtCk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Can you please merge into next.

Thanks.

--jQYCLmEXCTXcS8CGYtCk
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,<br /><br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; Can you please merge into next.<br /><br />Thanks.

--jQYCLmEXCTXcS8CGYtCk--

--3SNPHJ2QkyrgcvtxA1c2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6702): https://lists.cip-project.org/g/cip-dev/message/=
6702
Mute This Topic: https://lists.cip-project.org/mt/84788389/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3SNPHJ2QkyrgcvtxA1c2--
