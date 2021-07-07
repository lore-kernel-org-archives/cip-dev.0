Return-Path: <SRS0=Q3zd=L7=lists.cip-project.org=bounce+64572+6595+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B61C07E95
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 06:47:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C599A61C7C
	for <cip-dev@archiver.kernel.org>; Wed,  7 Jul 2021 06:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C599A61C7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6595+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wrnFYY4521723x0nvvrW4KvA; Tue, 06 Jul 2021 23:47:02 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.17852.1625640421151099392
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jul 2021 23:47:01 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 1676kvAD013480
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jul 2021 08:46:58 +0200
X-Received: from [167.87.42.31] ([167.87.42.31])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1676kuM8028860;
	Wed, 7 Jul 2021 08:46:57 +0200
Subject: Re: [cip-dev] isar-cip-core unhappy with our current runners
To: Michael Adler <michael.adler@siemens.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20210707061405.cb2uqez2x5xnuvrh@kratos.fritz.box>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <c1471b55-097e-9672-cf29-5fd579a23cdb@siemens.com>
Date: Wed, 7 Jul 2021 08:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707061405.cb2uqez2x5xnuvrh@kratos.fritz.box>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XNplaXYBVPx8PfLBpwzhly2mx4520388AA=
Content-Type: multipart/mixed; boundary="jHa8L6Crgh6nYLWLJUUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625640422;
 bh=mlpMW35yd1LcH0QqtkhbJwstarvoutZQX3xQDjrCMfg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IGGoLnD+nplDwlwGQhU92NSqQQZSzFN+bSE27TA2hlJ05nr5+VN3O99JHzXcFbPBC5x
 JDhr5h1EhgoZrigwT2JYmVufGpyXXpVqpGVNIsnA5fh1IgddupWD2ggcAeqT//NtVFcj8
 NKwabErBaHD+Nz/xQ6RcNm0gXP45yL8mHM8=

--jHa8L6Crgh6nYLWLJUUc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 07.07.21 08:14, Michael Adler wrote:
> Hi Jan,
> 
>> maybe someone has a clue: isar-cip-core does not build anymore with the
>> current runners, see e.g.
> 
> yes, I might have a clue: I upgraded the runners to v14 two weeks ago [1]. I have downgraded our runners back to v13
> [2].  Please let me know if that does the trick. Then either we found a regression in the v14 runner (which might
> already be fixed by now) or we need to adjust the configuration (I have a feeling that the privileged flag is not
> propagated correctly).
> 

Yes, looks better again:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/1404904190

>> I'm also not sure, given that we have two group runners available now,
>> if they differ and if isar-cip-core will use the right one. Maybe
>> additional tags are needed?
> 
> I think it was the correct runner. We have a large (tag 'large') and small (tag 'small') runner: The large runner allows
> privileged, the small one doesn't (anymore).
> 

Shouldn't we add tags to our .gitlab-ci.yml then? The group runners
cannot be individually selected for a repo, thus isar-cip-core will pick
from both, I think.

Jan

> Kind Regards,
>   Michael
> 
> [1] https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci/-/commit/7920a9105743c96db548c06faac28243d7cd9c96
> [2] https://gitlab.com/cip-project/cip-testing/gitlab-cloud-ci/-/commit/6e9b58da1a557be4ca602822ad4b8f23f172a2d3
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--jHa8L6Crgh6nYLWLJUUc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6595): https://lists.cip-project.org/g/cip-dev/message=
/6595
Mute This Topic: https://lists.cip-project.org/mt/84024159/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jHa8L6Crgh6nYLWLJUUc--
