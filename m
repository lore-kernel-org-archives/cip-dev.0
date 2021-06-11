Return-Path: <SRS0=jdaO=LF=lists.cip-project.org=bounce+64572+6505+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C6EC48BE0
	for <cip-dev@archiver.kernel.org>; Fri, 11 Jun 2021 14:30:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBABE613AE
	for <cip-dev@archiver.kernel.org>; Fri, 11 Jun 2021 14:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBABE613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6505+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qaxJYY4521723xAP9fRyc8mb; Fri, 11 Jun 2021 07:30:24 -0700
X-Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web08.9350.1623421823270652099
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jun 2021 07:30:23 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 15BEUKC5023832
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jun 2021 16:30:20 +0200
X-Received: from [167.87.248.115] ([167.87.248.115])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 15BEUIa9019120;
	Fri, 11 Jun 2021 16:30:19 +0200
Subject: Re: [cip-dev][isar-cip-dev][PATCH 2/2] swupdate: Add option to use swupdate-handler-roundrobin
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org, christian.storm@siemens.com,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
References: <20210611142112.2453-1-Quirin.Gylstorff@siemens.com>
 <20210611142112.2453-3-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <2a6cbfde-7bc4-7d78-ff0b-0c28b7753eb0@siemens.com>
Date: Fri, 11 Jun 2021 16:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210611142112.2453-3-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OVbNMbo0V7uH0aH5vbiIDhHVx4520388AA=
Content-Type: multipart/mixed; boundary="MMnxKPP6y88p8YqlxX5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623421824;
 bh=LNkThgUv1zHs31G2VtgECXeJ5/5enCwyVg2CfG4VoFA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=kEY/Z9mZUMpjuidTMErug5NwAyqAkHVz5E543K+3t4hQG9fxSHx+rwtbP4X/Omjw2ZC
 kfRBJqv+WpYXQGkrEGVFCpE+EYYpGYLXvIyycfTDu4OX5k0nw9SDmtDxOf2JHXCir+KSn
 U3Hw36NCw2w7L0oT84yNhJ6vxAlH8FWoXC0=

--MMnxKPP6y88p8YqlxX5R
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 11.06.21 16:21, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The new SWUpdate round-robin handler is available under[1].
> Add the Option `SWUPDATE_HANDLER_BOOT_HANDLER_CONFIG` to
> set the source of the swupdate-handler-roundrobin configuration.
> 
> If another Lua handler should be used,  set the variable
> `SWUPDATE_USE_ROUND_ROBIN_HANDLER_REPO` to `0`. Add the alternative
> handler to the repository and use the variable
> `SWUPDATE_LUASCRIPT` to add the handler to the build.
> 
> [1]:https://gitlab.com/cip-playground/swupdate-handler-roundrobin/
> 

What's still missing to get the script repo out of its playground? I
would obviously prefer already referencing the final URL if that is in
sight (I know there will be forwarding as well).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--MMnxKPP6y88p8YqlxX5R
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6505): https://lists.cip-project.org/g/cip-dev/message=
/6505
Mute This Topic: https://lists.cip-project.org/mt/83469366/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MMnxKPP6y88p8YqlxX5R--
