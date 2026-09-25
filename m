Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93263C9830E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 07:26:08 +0000 (UTC)
Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3090.1790321157938319750
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 00:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=qVM03i+K;
 spf=pass (domain: miraclelinux.com, ip: 74.125.227.169, mailfrom: hirotaka.motai@miraclelinux.com)
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so346457a91.1
        for <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1790321157; x=1790925957; darn=lists.cip-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=liDWrk7zqJhmcN2XIsvdbFI4HdsL6IUj++Ts9rrb0m4=;
        b=qVM03i+KZZXsdABeAUma1wQlJSbTCi/16jfCWUbWsKh6+zY59X/c6VtqQxy3wmHZ3T
         PqI+pzpblbmJZILrg9gaBva9n2+LI72i9qrrZEJwGtAMf+PF/+igy0f9BR/MxxluDKs9
         u29V/TMlWVm1ygZNEo4R8c8rd8zv+y3fc9PE6mupS21d/oeYLiiGB5kdeDhs/BcCaU6L
         F5DbI+xFWiWJXkhP+aSDC+Sz/4YP8287/IDQq316dSvdZzUHm722X7Ko9B+HoWNZ5QNg
         cZsRe+IcFYwp9kxswZVkvqp2MGSbtAm1hzo8zETuWI1yQ+Zcsu7xzbeagu6ey2IB5hrE
         bhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321157; x=1790925957;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=liDWrk7zqJhmcN2XIsvdbFI4HdsL6IUj++Ts9rrb0m4=;
        b=kofUdMjI5cEoFN671NKiPcKi4Oe1ijsXMfhbSS0UhRiHeZVSlv52TWm17RtHAysamM
         I6Qo5RCpDkg8nGzZao9eH8+1V339bHNiBUgQdZct2Tvwzo/3bY8JHTHlVKamBlanAIfS
         jg/aMrinGu3zSRdOo3QAx+0nw2ZKxl/SPLwkmxvnGpH6dP+Q5kvAi78CvFllKSsa6qdZ
         bfvbDOu4C5QspaAKIKvbghveTRrLHeCycE2CfKhscRWFxEYsvrUOWlpV3QUsYPS4MMMA
         VsGnRxCi1CvRABDdqYWlBEMRTzyqPa+4Jq0bKN9t6SKsKHw4Hj3RbxFqDIpZ+XZb4Ats
         0aLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuBEwJLN6fhbWZu8pUUHJ3X/jrqxRtTI/LEHKjkV3BjkzExGHLZpkXcjoaeoS723HUJnPnYW7Z@lists.cip-project.org
X-Gm-Message-State: AFuF++n8xKqOrwZew1swC+8Q+56vEVR/fLZtVvIwBK96NKhZh0FZrIhm
	xa7lUxqNN1jP63poMxu9kYnVIj9kEuMiyMZ0dkPgC+7InuZlVyGf7utI18c6y39soyw=
X-Gm-Gg: AYBFou0jHk2G+fe7bnbnu0EaBlWpBliiJwN12lhkuw1zVR9FpyVKfQooVBrKPr/j98Z
	DIqw7gTlp/pMY68l8ZrXCRFcjIRrIydn9l9xhyTr0Xza8soCKZddhb1LoyHTdC9eltWns6vxZlN
	5ytovgtx0nP7nQFQ22TOXGETiaACei5uWz0m3yPIuZS6awXd3Xc5mkzlZ9EU17S24VTAV5M1vPP
	j3A0aaTMFxbALs0/IjuXy5DRfUPJUeXDDeqXIKqgwqLAO3KSblcAR0FpLjzH7BNbwBEN3jmsl/r
	HJb8SczH+9vtOB707OloMEtMhUs6Jr/r/Qvvsrgx5i4Su+LQFAoSkYyFZmqQk2O6YDzo7JRZmB6
	UqPIxmIQrRegkVhrjCV4+/fdM39UjSb0WM+f9PU4aMEq9Ylk/9PhX8DXnuMis2KJzyo+2KJFlB7
	dK3RZt6AJXE/Z8nKeE35Qp2xdo/Tovb+8IDMD7uVlajxx8k8cA/ktiZeXK6ODKS+YQ5fL91YpkC
	gjIdnkBhsD8Swzu/vZFczVGEZVwalOuwZa9faFdmQ8XxzbGY8E=
X-Received: by 2002:a17:90b:917:b0:39e:6c69:7777 with SMTP id 98e67ed59e1d1-3a0989866e6mr2963400a91.32.1790321156996;
        Fri, 25 Sep 2026 00:25:56 -0700 (PDT)
Received: from [192.168.0.117] (FL1-133-203-46-83.tky.mesh.ad.jp. [133.203.46.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec711sm9151980a91.6.2026.09.25.00.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 00:25:56 -0700 (PDT)
Message-ID: <8229d22c-889a-45e4-9726-6b6bc5d7b2d4@miraclelinux.com>
Date: Fri, 25 Sep 2026 16:25:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add SECURITY.md
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: kumar.dinesh.h95@mail.toshiba
References: <7c5a1901-7536-435c-aecb-bfdf3a8a9d6f@siemens.com>
 <28467eec-7feb-4bb0-8c2f-a73ca9c4b6f7@siemens.com>
Content-Language: en-US
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
In-Reply-To: <28467eec-7feb-4bb0-8c2f-a73ca9c4b6f7@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 07:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24343

Hi Jan,

Sorry for the delayed response.

On 2026/09/21 14:25, Jan Kiszka wrote:
> On 14.09.26 10:03, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This documents that isar-cip-core falls under the LF CRA stewardship
>> framework, describes what we consider in scope for vulnerability reports
>> and defines the reporting channel via the CIP security mailing list.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> We will need something for the kernel as well, and also for other CIP 
>> components. This is just a start and, if it makes sense for all, can act 
>> as a template.
>>
>>  SECURITY.md | 37 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 SECURITY.md
>>
>> diff --git a/SECURITY.md b/SECURITY.md
>> new file mode 100644
>> index 00000000..664a303f
>> --- /dev/null
>> +++ b/SECURITY.md
>> @@ -0,0 +1,37 @@
>> +# Security Policy
>> +
>> +This project is supported under the Linux Foundation CRA stewardship framework,
>> +as described at https://www.linuxfoundation.org/security. Security
>> +vulnerabilities should be reported through the mechanisms described below,
>> +which we will coordinate with our CRA steward. For actively exploited
>> +vulnerabilities and severe incidents that may require CRA escalation, please
>> +use the project’s emergency security reporting mechanisms as appropriate.
>> +
>> +## Security Context
>> +
>> +Open source software can be used in various contexts that may go far beyond
>> +what it was originally designed and also secured for. Therefore, we describe
>> +here how isar-cip-core is expected to be used in security-sensitive scenarios.
>> +
>> +This project provides building blocks and reference configurations to create
>> +secured systems that support secure updates. Demonstration images that can be
>> +created from it may use publicly known keys or contain debugging features not
>> +intended for production use. It is the responsibility of the final integrator
>> +of this project to use appropriate keys and harden the system integration. This
>> +includes the choice of secured Debian package versions.
>> +
>> +In scope for vulnerability reports against this project are flaws in new or
>> +customized packages provided here which contribute to the security of a final
>> +system. Furthermore in scope are noteworthy documentation deficits regarding
>> +how to achieve secure usage of these packages.
>> +
>> +## Reporting a Vulnerability
>> +
>> +Please DO NOT report any potential security vulnerability via a public channel
>> +(mailing list, gitlab issue etc.). Instead, contact the CIP security team via
>> +security@cip-project.org via email. Please provide a detailed description of
>> +the issue, the steps to reproduce it, the affected versions and, if already
>> +available, a proposal for a fix. You should receive a response within 5 working
>> +days. If the issue is confirmed as a vulnerability by us, we will request a
>> +CVE, publish the fix and give credits for your report if desired. This project
>> +follows a 90 day disclosure timeline.

I have reviewed the commit, and it looks good to me.
No further comments.

> Gentle reminder to provide feedback on this. We are getting closer to
> the next release, and this will have to carry a security policy.
> 
> Jan
> 

Hiro



