Return-Path: <SRS0=OPnr=OY=lists.cip-project.org=bounce+64572+6773+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF16C433FE
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 12:13:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7706113A
	for <cip-dev@archiver.kernel.org>; Mon,  4 Oct 2021 12:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE7706113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BYuZYY4521723xE90cZXAkfq; Mon, 04 Oct 2021 05:13:14 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web09.8410.1633349593394989512
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Oct 2021 05:13:14 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 194CD7qM016289
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 4 Oct 2021 14:13:08 +0200
X-Received: from [167.87.3.213] ([167.87.3.213])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 194CD7p0031831
	for <cip-dev@lists.cip-project.org>; Mon, 4 Oct 2021 14:13:07 +0200
X-Mozilla-News-Host: news://lore.kernel.org:119
To: cip-dev <cip-dev@lists.cip-project.org>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: [cip-dev] Duplicate messages in archive
Message-ID: <cb92b212-2b64-3517-0ab6-7300bd83f752@siemens.com>
Date: Mon, 4 Oct 2021 14:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fiqDPeGBgrlQ1qK7ATAea8zJx4520388AA=
Content-Type: multipart/mixed; boundary="FfICZtjdr6akllfL5FhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633349594;
 bh=mebtSe8d1cATnj5ltClct6/KMw3pUS1JpowKdVQXYFY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=R4cFb5ASEZEIQlm6DrdkLCRXMfqR6n+QYmeI0v2eBSKSQnnPDGGAyEnkOFKqg1ONvC9
 EJ7BsfjF703l9x8rapkorgcqxL26vzzK21fsxEDlTbBZy5MNlPCbS5te9+ZWYQp2Qi8Eg
 +qiNIYQTRh8u/eRVkhBeE1uOTC/UuEHlZtM=
Message-ID: <20211004121307.0qz2n6zSH7Wj0-iF_61ANIiMOe91aKAJv2on0bQtvqQ@z>

--FfICZtjdr6akllfL5FhU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi all,

did anyone already examined or reported that all messages to cip-dev now
seem to get archived twice on lore.kernel.org? See e.g.
https://lore.kernel.org/cip-dev/TYAPR01MB6252C6286EDCA87D7DB8B10892AE9@TYAPR01MB6252.jpnprd01.prod.outlook.com/T/#t

They also appear twice via nntp, that's how I noticed, but are likely
not sent twice to subscribers.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--FfICZtjdr6akllfL5FhU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6773): https://lists.cip-project.org/g/cip-dev/message/=
6773
Mute This Topic: https://lists.cip-project.org/mt/86064692/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FfICZtjdr6akllfL5FhU--
