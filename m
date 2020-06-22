Return-Path: <SRS0=PnBF=AD=lists.cip-project.org=bounce+64572+4808+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B0DC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 22 Jun 2020 06:52:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826D22542E
	for <cip-dev@archiver.kernel.org>; Mon, 22 Jun 2020 06:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XYZGzQcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826D22542E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4808+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JbwMYY4521723xvrgmd7AF3j; Sun, 21 Jun 2020 23:52:26 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.11899.1592808744420320798
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Jun 2020 23:52:25 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 05M6qLJC022634
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2020 08:52:21 +0200
X-Received: from [139.22.110.241] (wpdkn10-01941.ad009.windad.org [139.22.110.241] (may be forged))
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05M6qLjv025920;
	Mon, 22 Jun 2020 08:52:21 +0200
Subject: Re: [cip-dev] Share your suggestions for supporting session lock requirement in CIP
To: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
Cc: "cip-security@lists.cip-project.org"
 <cip-security@lists.cip-project.org>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <3999decc9e9743b7b4061b38b91f4575@TOSHIBA-TSIP.COM>
 <03bbeb30-2599-a061-cf48-f4f2b1341408@siemens.com>
 <32eb6554a6e8483c853c0a3ef4d91ecf@TOSHIBA-TSIP.COM>
 <3cd909ac-602a-a7c5-ecad-963de18a9e64@siemens.com>
 <11a1bf2f05004c61ad6f171e74197eb5@TOSHIBA-TSIP.COM>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <7635bb53-9fb9-eff9-5543-8ee322ded196@siemens.com>
Date: Mon, 22 Jun 2020 08:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <11a1bf2f05004c61ad6f171e74197eb5@TOSHIBA-TSIP.COM>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: g8xLFLAyi6ntf5gDZVxnWIdKx4520388AA=
Content-Type: multipart/mixed; boundary="GHDaMYHKJk2HvjTHHqrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1592808746;
 bh=jOE//HzcGE+ApW8u381XiknA6h98CESm9y24RmKUW3g=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XYZGzQcjr8L0iClw6GElHxPFEvqyaW+v+XA9jrHQNNg9o0LS7iI+XNg30PhKn8zw6UG
 hSrCSDmVbfqauwPVbiUPm3sgbpWCnpT+j16Ht5BUggzoW59ozYH3gLACG/egfgbzZOgRJ
 22Jhmimm303lrQEgNVzESoKJ+KBwnllcx4E=

--GHDaMYHKJk2HvjTHHqrq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 21.06.20 10:23, Dinesh Kumar wrote:
> Hi Jan,
> 
> I have added my comments, please let me know your views.
> 
> Thanks & Regards,
> Dinesh Kumar
> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com> 
> Sent: 16 June 2020 12:39
> To: Dinesh Kumar <Dinesh.Kumar@TOSHIBA-TSIP.COM>
> Cc: cip-security@lists.cip-project.org; cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] Share your suggestions for supporting session lock requirement in CIP
> 
> On 16.06.20 09:00, Dinesh Kumar wrote:
>> Hi Jan,
>>
>> Thanks for your review comments.
>> Kindly refer my response and let me know your opinion.
>>
>> Thanks & Regards,
>> Dinesh Kumar
>>
>>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 15 June 2020 12:52
>> To: cip-dev@lists.cip-project.org; Dinesh Kumar 
>> <Dinesh.Kumar@TOSHIBA-TSIP.COM>
>> Cc: cip-security@lists.cip-project.org
>> Subject: Re: [cip-dev] Share your suggestions for supporting session 
>> lock requirement in CIP
>>
>> Hi Dinesh,
>>
>> On 10.06.20 15:02, Dinesh Kumar wrote:
>>> Hi All,
>>>
>>> IEC-62443-4-2 has following two requirements related to session termination and session lock.
>>> CR2.5 Req-1 Session lock: Component should support session lock after a configurable time period of inactivity.
>>
>> Why not simply enforce log out also for local (terminal) sessions?
>> Dinesh>>Yes, we can do that by using TMOUT.  However, we were just trying if we can achieve session lock with some existing packages or minimal changes in CIP. But that does not seem to happen.
>>                  Our idea of sharing this detail here was if anyone can suggest achieving session lock with some Debian packages without any modifications in the packages.   
>>                  TMOUT is our backup option.             
>>
>>> CR2.6 Req-2 Remote session termination: Component should support 
>>> terminating remote session after a configurable time of inactivity
>>>
>>> CR2.6 Req-2 can be met by adding system variable TMOUT.
>>>
>>> For meeting CR2.5 we need following changes in CIP.
>>>
>>> 1.       Systemd code changes
>>>
>>
>> Why?
>> Dinesh>>Since idle_action=lock is disabled in current systemd code. We enabled with changes described in this email. Though it works but we are not sure about side effects.
> 
> But that mode is documented in systemd manuals - without any note that it's in fact off? Something does not match here yet. At least, it would be a documentation bug, but maybe also a chance to enhance the code and sell it upstream.
> Dinesh>>It's not documented in systemd manuals as well, not even any note whether it has been intentionally kept off.

"lock" is documented as offical option for IdleAction:
https://www.freedesktop.org/software/systemd/man/logind.conf.html#IdleAction=

Jan

> 
>>
>>> 2.       Add deamon which subscribes to dbus notification(sample code attached)
>>>
>>
>> Why is IdleAction=lock in logind.conf insufficient?
>> Dinesh>>It's sufficient but disabled.
>>
>>> 3.       Add vlock Debian package which performs session lock
>>
>> What is still missing after configuring this package?
>>
>> And what about physlock?
>> Dinesh>>We quickly checked physlock, it's better alternate to vlock. But first we have to decide systemd changes, since vlock or physlock only work if systemd code changes are enabled.
>>
> 
> OK. Still confused, though, because there is no mentioning of that somewhere. Unless I miss that. Is there any Debian bug? Or even an systemd issue?
> Dinesh>>We searched Debian systemd bugs in Debian but there is no related bug found. So we have a raised a bug in Debian as attached.
> 
>>>
>>> 4.       Enable dbus in systemd
>>
>> What do you mean by that?
>> Dinesh>>Sorry for confusing you. I meant dbus is an optional dependency of systemd package which is required to be enabled in CIP if we want to achieve session lock with systemd.
>>
> 
> OK, so this is about adding dbus to our package set - not unrealistic.
> 
>>>
>>> Systemd code change are as follows.
>>>
>>>
>>> --- a/src/login/logind.c
>>>
>>> +++ b/src/login/logind.c
>>>
>>> @@ -1019,7 +1019,7 @@ static int
>>> manager_dispatch_idle_action(sd_event_source *s, uint64_t t, void *us
>>>
>>>                      (m->idle_action_not_before_usec <= 0 || n >=
>>> m->idle_action_not_before_usec + m->idle_action_usec)) {
>>>
>>>                          log_info("System idle. Taking action.");
>>>
>>>
>>>
>>> -                        manager_handle_action(m, 0, m->idle_action, false, false);
>>>
>>> +                        manager_handle_action(m, 0, m->idle_action, 
>>> + false, true);
>>>
>>>                          m->idle_action_not_before_usec = n;
>>>
>>>                  }
>>>
>>
>> What is the semantic of this code change? Can this be sold as a feature to systemd so that it may become configurable (avoid the patch)? Or is it even a generic feature that everyone wants?
>> Dinesh>>This code simply enables idle_action=lock. I am not sure why they have kept it disabled. Should we post this change in upstream and ask them whether it can be made configurable?
> 
> Yes, this needs to be be clarified. Otherwise, we cannot decide how to move on.
> Dinesh>>Sure, we have created a bug, hopefully we will have clear direction when someone replies.
> 
>>
>>> It means there are several changes required in CIP as well as it would be difficult to maintain for long term, if we chose this option.
>>>
>>> My request is, if anyone has any better idea to achieve session lock, please share so we can evaluate it further.
>>
>> Always think upstream first: Describe your feature clearly and sell it to the component that can implement it best. Once accepted, we can still look into how to bridge the time best until it hits a Debian release.
>>
>> So, please describe the problem technically, including why existing tools do not fulfill the requirements. And which tools or methods you examined already.
>> Dinesh>>Thanks for your inputs. 
>>                  We have raised our query in systemd ML to know why lock action is disabled but no one has responded so far.
>>
> 
> If there is an integration issue with systemd + vlock/physlock under Debian, it may also be an option to open an ticket there so that Debian maintainers call push it or provide further input.
> Dinesh>>Agree, we have to wait for the response from Debian then decide next.
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
> The information contained in this e-mail message and in any
> attachments/annexure/appendices is confidential to the 
> recipient and may contain privileged information. 
> If you are not the intended recipient, please notify the
> sender and delete the message along with any 
> attachments/annexure/appendices. You should not disclose,
> copy or otherwise use the information contained in the
> message or any annexure. Any views expressed in this e-mail 
> are those of the individual sender except where the sender 
> specifically states them to be the views of 
> Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
> 
> Although this transmission and any attachments are believed to be
> free of any virus or other defect that might affect any computer 
> system into which it is received and opened, it is the responsibility
> of the recipient to ensure that it is virus free and no responsibility 
> is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
> damage arising in any way from its use.
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--GHDaMYHKJk2HvjTHHqrq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4808): https://lists.cip-project.org/g/cip-dev/message=
/4808
Mute This Topic: https://lists.cip-project.org/mt/74795832/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GHDaMYHKJk2HvjTHHqrq--
