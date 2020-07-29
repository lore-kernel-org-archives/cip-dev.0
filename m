Return-Path: <SRS0=rYMA=BI=lists.cip-project.org=bounce+64572+5049+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E70AC433DF
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 16:57:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2683207F5
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 16:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fDBNH3kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2683207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5049+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wE9zYY4521723xgxYxZJ8E9A; Wed, 29 Jul 2020 09:57:31 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web11.586.1596041849599518655
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 09:57:30 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 06TGvRql002852
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2020 18:57:28 +0200
X-Received: from [167.87.13.2] ([167.87.13.2])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06TGvRJv025891;
	Wed, 29 Jul 2020 18:57:27 +0200
Subject: Re: [cip-dev] [isar-cip-core 0/3] Security Branch patches
To: cip-dev@lists.cip-project.org,
        Venkata Pyla <venkata.pyla@toshiba-tsip.com>
References: <20200727114135.368-1-venkata.pyla@toshiba-tsip.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <7f2ed407-8e8a-8810-2fac-d52bd892ccc3@siemens.com>
Date: Wed, 29 Jul 2020 18:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727114135.368-1-venkata.pyla@toshiba-tsip.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Y0C0Auq4uJLOtdHrbxWeIs1Ux4520388AA=
Content-Type: multipart/mixed; boundary="t2nlIho29uxRocsVPiyh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596041851;
 bh=0cZMRDFlWFBJIpVvqk/aKCw/TdCt+3cadblUhMVfcn4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fDBNH3kNKE8hNvcFe3nYTU9jy5C/a2nPteUq9r6+ghEA4XcwG064sCnS8h5kclac2su
 NC0diVut5OIyBEsiE/PBgFhRSES6q1EfdrZWikpdWmfUk8/qiu5kwYdV1YZ/VrNfsRvlo
 bIi4mPucX1A/xBTVGR7gt87nJA0ArPI8vDk=

--t2nlIho29uxRocsVPiyh
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 27.07.20 13:41, Venkata Pyla wrote:
> From: Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> 
> Patch series for Security changes for IEC-62443-4-2 evaluation
> 
> Kazuhiro Hayashi (1):
>    cip-security: Add packages for IEC-62443-4-2 evaluation
> 
> Venkata Pyla (2):
>    start-qemu.sh: Use 'TARGET_IMAGE' to pick respective image file
>    README: Add steps to build cip-security image
> 
>   README.md                                     | 10 ++++++
>   .../images/cip-core-image-security.bb         | 36 +++++++++++++++++++
>   start-qemu.sh                                 |  6 +++-
>   3 files changed, 51 insertions(+), 1 deletion(-)
>   create mode 100644 recipes-core/images/cip-core-image-security.bb
> 

Applied to next - now awaiting the patch for .gitlab-ci.yml ;)

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--t2nlIho29uxRocsVPiyh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5049): https://lists.cip-project.org/g/cip-dev/message=
/5049
Mute This Topic: https://lists.cip-project.org/mt/75820360/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--t2nlIho29uxRocsVPiyh--
