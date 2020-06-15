Return-Path: <SRS0=gZ/y=74=lists.cip-project.org=bounce+64572+4797+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58183C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 15 Jun 2020 07:22:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF1B2068E
	for <cip-dev@archiver.kernel.org>; Mon, 15 Jun 2020 07:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QbNsZPqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF1B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4797+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yuueYY4521723x64NX3SYEbx; Mon, 15 Jun 2020 00:22:12 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.12173.1592205730392619606
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2020 00:22:11 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 05F7M7rI030405
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2020 09:22:08 +0200
X-Received: from [139.22.110.225] (md2df08c.ad001.siemens.net [139.22.110.225] (may be forged))
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05F7M6aC009716;
	Mon, 15 Jun 2020 09:22:07 +0200
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Share your suggestions for supporting session lock requirement in CIP
To: cip-dev@lists.cip-project.org,
        Dinesh Kumar <dinesh.kumar@toshiba-tsip.com>
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>
References: <3999decc9e9743b7b4061b38b91f4575@TOSHIBA-TSIP.COM>
Message-ID: <03bbeb30-2599-a061-cf48-f4f2b1341408@siemens.com>
Date: Mon, 15 Jun 2020 09:22:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3999decc9e9743b7b4061b38b91f4575@TOSHIBA-TSIP.COM>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1SL8AQMddA1CsJAdDAtO7xbKx4520388AA=
Content-Type: multipart/mixed; boundary="omLUhd4IThAgE2PrzJWF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592205732;
 bh=Z+PJ6iKAPcNAB29y8lO5rm+fKp9aQFHJMnTKjFScL8A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QbNsZPqMNXw5iQYCzQvB6kxGo2lxcedQZVjzyRHdUcaFl6CUmnqc8LVNZ9EIB9Gg8bx
 U5NPoZzW9yRMt9jOwbQwlTqKhr8D4myO+QqvaIQiqbnkhsnNd6UjKAtbZFE+jSWUMYVR3
 j3EnLO47Oh5dffvRjfrYfWPLlmUw3WTAyP0=

--omLUhd4IThAgE2PrzJWF
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Dinesh,

On 10.06.20 15:02, Dinesh Kumar wrote:
> Hi All,
> 
> IEC-62443-4-2 has following two requirements related to session termination and session lock.
> CR2.5 Req-1 Session lock: Component should support session lock after a configurable time period of inactivity.

Why not simply enforce log out also for local (terminal) sessions?

> CR2.6 Req-2 Remote session termination: Component should support terminating remote session after a configurable time of inactivity
> 
> CR2.6 Req-2 can be met by adding system variable TMOUT.
> 
> For meeting CR2.5 we need following changes in CIP.
> 
> 1.       Systemd code changes
> 

Why?

> 2.       Add deamon which subscribes to dbus notification(sample code attached)
> 

Why is IdleAction=lock in logind.conf insufficient?

> 3.       Add vlock Debian package which performs session lock

What is still missing after configuring this package?

And what about physlock?

> 
> 4.       Enable dbus in systemd

What do you mean by that?

> 
> Systemd code change are as follows.
> 
> 
> --- a/src/login/logind.c
> 
> +++ b/src/login/logind.c
> 
> @@ -1019,7 +1019,7 @@ static int manager_dispatch_idle_action(sd_event_source *s, uint64_t t, void *us
> 
>                      (m->idle_action_not_before_usec <= 0 || n >= m->idle_action_not_before_usec + m->idle_action_usec)) {
> 
>                          log_info("System idle. Taking action.");
> 
> 
> 
> -                        manager_handle_action(m, 0, m->idle_action, false, false);
> 
> +                        manager_handle_action(m, 0, m->idle_action, false, true);
> 
>                          m->idle_action_not_before_usec = n;
> 
>                  }
> 

What is the semantic of this code change? Can this be sold as a feature
to systemd so that it may become configurable (avoid the patch)? Or is
it even a generic feature that everyone wants?

> It means there are several changes required in CIP as well as it would be difficult to maintain for long term, if we chose this option.
> 
> My request is, if anyone has any better idea to achieve session lock, please share so we can evaluate it further.

Always think upstream first: Describe your feature clearly and sell it
to the component that can implement it best. Once accepted, we can still
look into how to bridge the time best until it hits a Debian release.

So, please describe the problem technically, including why existing
tools do not fulfill the requirements. And which tools or methods you
examined already.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--omLUhd4IThAgE2PrzJWF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4797): https://lists.cip-project.org/g/cip-dev/message=
/4797
Mute This Topic: https://lists.cip-project.org/mt/74795832/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--omLUhd4IThAgE2PrzJWF--
