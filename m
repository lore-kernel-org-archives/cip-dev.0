Return-Path: <SRS0=zFKs=MT=lists.cip-project.org=bounce+64572+6634+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F6C432BE
	for <cip-dev@archiver.kernel.org>; Tue, 27 Jul 2021 11:48:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F3C61A35
	for <cip-dev@archiver.kernel.org>; Tue, 27 Jul 2021 11:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 84F3C61A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id s2dlYY4521723xyB7NoMmDSl; Tue, 27 Jul 2021 04:48:22 -0700
Subject: Re: [cip-dev] [isar-cip-core][PATCH] images: Enable inclusion of swupdate.inc by external layers
To: cip-dev@lists.cip-project.org
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
X-Originating-Location: Noida, Uttar Pradesh, IN (192.94.34.34)
X-Originating-Platform: Windows Chrome 91
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 27 Jul 2021 04:48:21 -0700
References: <096ae2a4-58bf-e622-7073-453e29bb7136@siemens.com>
In-Reply-To: <096ae2a4-58bf-e622-7073-453e29bb7136@siemens.com>
Message-ID: <21735.1627386501702340408@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PNgC7EFKFhKsNNhquVj4eFeYx4520388AA=
Content-Type: multipart/mixed; boundary="7zmk7HzI2uwsUfgU1BDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627386502;
 bh=4IRzax4+R0QhQOuDGe22Dn0ebqJyTOAFmDQbrcqL8XU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=iAWPLc32oGjqz7ah/c0jkqywPnsxGG6NZS75WqjKMbaG6AuSlpzAFlcpGP5hZFjZFaA
 cqtiKkGAnZ0carXYQBNSL5k7hKfkEGoBtnkJw+JSmVh3lBIFQPdUuMi5GtJpH8+YMUf/D
 LHHPFZOuK18ECsEcZauRhWgXizORg7ovTN0=

--7zmk7HzI2uwsUfgU1BDD
Content-Type: multipart/alternative; boundary="fmGZUJM5L2YEs83LGWBu"

--fmGZUJM5L2YEs83LGWBu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Jan,

We added swupdate recipe in downstream isar-siemens layer now it pulls the=
 sw-description.tmpl file. It's working fine. Please sync with master. Than=
ks.

--fmGZUJM5L2YEs83LGWBu
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Jan,<br />&nbsp; &nbsp;&nbsp;<br />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; We added swupdate recipe in downstream isar-siemens layer n=
ow it pulls the sw-description.tmpl file. It's working fine. Please sync wi=
th master. Thanks.

--fmGZUJM5L2YEs83LGWBu--

--7zmk7HzI2uwsUfgU1BDD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6634): https://lists.cip-project.org/g/cip-dev/message=
/6634
Mute This Topic: https://lists.cip-project.org/mt/84453358/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7zmk7HzI2uwsUfgU1BDD--
