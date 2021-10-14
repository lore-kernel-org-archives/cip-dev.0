Return-Path: <SRS0=oXox=PC=lists.cip-project.org=bounce+64572+6827+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ABFC4332F
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 10:09:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9107F6101E
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 10:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9107F6101E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BEtaYY4521723xXQU4yqbCdL; Thu, 14 Oct 2021 03:09:26 -0700
Subject: Re: [cip-dev] [isar-cip-dev] [PATCH] Update efibootguard to latest one
To: cip-dev@lists.cip-project.org
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
X-Originating-Location: Noida, Uttar Pradesh, IN (192.94.34.34)
X-Originating-Platform: Windows Chrome 94
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 14 Oct 2021 03:09:25 -0700
References: <a1dab3d1-9b9b-1fba-d8df-90ca63e5c23e@siemens.com>
In-Reply-To: <a1dab3d1-9b9b-1fba-d8df-90ca63e5c23e@siemens.com>
Message-ID: <16176.1634206165656056868@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PQhVPqPO5krdp0ROMwi8RlJmx4520388AA=
Content-Type: multipart/mixed; boundary="BezTA16sCUJASHlxSG1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634206166;
 bh=55U2UsmMTnm1JohbS5xTEdxoiugs62cyLFXuGHYkrYE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=woMg+uUJLnmPBRZfNGMSRp+K9AFKHOsDkjnPSWhnD7viuo1wZh/VsJrr2uYWkXBmFDW
 s9c1zmfmXa6EnW7njzeimQxP61g3lzSp7OZhR+qSXBcYlp4h8ly3HrXsNi7QYQLJGWKsf
 qZjzjbbrr5XdGoj0xKrQDXpLhNosC+B+kXM=
Message-ID: <20211014100925.API_K0xlCQf2IsCPaQ8jjCeoJIpYc_r5UDSBKoIcziM@z>

--BezTA16sCUJASHlxSG1W
Content-Type: multipart/alternative; boundary="U3BRSoCa37FkzZ9xHoqp"

--U3BRSoCa37FkzZ9xHoqp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

yes quirin i missed this PROVIDES, actually i want this latest master chang=
es to build efibootguard for bullseye distro, can anyone make the release s=
o that i can use this latest tag 0.9.

Thanks, Srinuvasan.A

--U3BRSoCa37FkzZ9xHoqp
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

yes quirin i missed this PROVIDES, actually i want this latest master chang=
es to build efibootguard for bullseye distro, can anyone make the release s=
o that i can use this latest tag 0.9.<br /><br />Thanks, Srinuvasan.A

--U3BRSoCa37FkzZ9xHoqp--

--BezTA16sCUJASHlxSG1W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6827): https://lists.cip-project.org/g/cip-dev/message/=
6827
Mute This Topic: https://lists.cip-project.org/mt/86308311/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BezTA16sCUJASHlxSG1W--
