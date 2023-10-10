Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C74CD80BB
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 12:04:18 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by mx.groups.io with SMTP id smtpd.web10.84071.1696913349888098661
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 21:49:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@web.de header.s=s29768273 header.b=J84eaeSc;
 spf=pass (domain: web.de, ip: 212.227.15.14, mailfrom: jan.kiszka@web.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696913347; x=1697518147; i=jan.kiszka@web.de;
 bh=RVhA1wDjbGhmGyrjeDCNJBb971JVFFJajbBioJBgJG8=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=J84eaeScBzGFGQ9l962yQxjI2OtrqzFp/QJmW3F9go5YQQwRkvSejUoLjMRcLdyNrfQu0jGZc3E
 Y7nTh4he12WQZfyZInBPyPw9D0pJ8VcK2ygsGNDpdRMvtTDiM+vmYg5Lgr7G1j8CLZH7bkqXw+C4U
 O1sVc6Gq35AdluV9cFsVtxdrRCBLg6mPP58a0jjz6gidYwTKvstrW0Bf5JRK/sU2yEque4ay5BdDF
 se+V1YJNdj/a4U1fTo3vTGJcymZjOb3VWxzGofmIuQys3JEd1IAoBiBSIZuIXbQPjQ50+DGuGFif/
 9w6hTbwdkjtAUhQ49PIgpQ8UENd2aGGaXG0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([46.128.188.24]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4fW-1qk48v2iV8-00BaJB for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 06:49:07 +0200
Message-ID: <b5ac57f6-a8fe-4cef-995a-25ad1e78f834@web.de>
Date: Tue, 10 Oct 2023 06:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: Closing time for isar-cip-core 1.2
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYAQTEQIAIAUCSrSLxAIbIwYLCQgHAwIEFQIIAwQWAgMB
 Ah4BAheAAAoJEIrUrG965ecUhIMAnR6DDCW5cx+cVdYhydbhQXqeief6AJ4p+z4+nrmZLdfU
 7V6nKqKeHeTtj87BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepKvIfi
 M8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+bgvM
 OsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hnclsZ/IY
 hXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVORTOtz
 FK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5gz88
 SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI3KCT
 67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdIvttw
 zG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPxbRea
 9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zpq61t
 oNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+NK8JJ
 BBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wHAJ46
 S16yab+OxNkvOeoOEX0EnHVHaA==
X-Provags-ID: V03:K1:uiq8e8MxL2iHM84XRklDLX6lfUqXaP7qufORi6lXb8vAUhpWY5/
 rDC/j8gonvMbozbu48UibzEOHqt9JRe0Lojq5xILDDmclhYAJeEO4bDHNhMKC0UmVLlzIoD
 OFN1My2nDoyqlB5FKHHsf6y8UTTgT2QNa0CES9Y7G4L+rZqsjvM2R5fkMiaQAAnVEd54Rlw
 NF72hMPWXCoYD0wRFXEYA==
UI-OutboundReport: notjunk:1;M01:P0:QLYP2YeBttA=;2+P9VdZsxc+GQ11d3DRcY84+bCs
 W1iX1v8qWw2DwIYYIWrfW1X7YORWp+dmzWLEAP3r/P1QR+Q7vmuvXJ59U8u/cdD1d4i/bun7X
 ZjavU57t3n5T2tXQidfkRp1mIcKF2wfJFjJYx2Xcvcq9edWV8Cd7P7GBSdRjaIF9sHNb1dy5d
 TDlm44SfeuPmsyfB3kbRqy8JQuOCU0rOveMbthHuDGrSNkScKvg6JgzbeoQQuomfMGo7MfCGb
 ASR12qa5bt1iq+80pg3oa0IP/oQCGZAQTz6OikJ59QgHcVsEdpwRxC4x8sJVGObtcMBrdpr0i
 2dkUzvDzTf25RLj1aKmSje8olOjUBMMHxK/vxjEJao/GdXc/E8C6x3ziAYJ3j+j+u7D4Mar7x
 NCzrGNMObbR1Bz587hR7aCRXNpaG9lCeps7SnbEHONu7FZGbhHET/A/CZS/gAdqIiOSTnLHcB
 Yty2gUPV9ITUchc78k628Idzk2t0/FjNbhv109Op7TkdvR8q2EKPAa6HT+BPiMbylE+8jiLb/
 PVY8a6w71eR0MW8O2M7bHpjssbmrq4oTObhicWcfBrSYkPdAl0KTImv6VTz1G4jmsZh/+FRcd
 bJ+e5JZzHCvt9feouaxycfFIb24hePt+dkx6bWqTaLT4D+IxuuYPv3FQACJUS/c7X1evYsuK2
 e2i7jCm7rNZckKBXegXuukIfL5IX4ezgBpkkfCN6QHq/COiK/5nvKhwW31jhytnrhFg3QNJdB
 oFiCzfP/HY5sLJlGrOoQ8SFMkA19+Le+ycrY0+SmOqYyQeeAxqQA84I4DeNrAqHB13v2dX6Xx
 6GoKFOZlv4K85QTYIJfKxvKgYfkQM6LEXnoGyguyGcZ1WQB6o6SZojbC0jQkOU5wqIqwhnFqp
 gPf2XC78KE6hh4gPzBx/gyEICG0RiZImpPf+nuJTulPDT3ATgfbam4+MW/i9sHKKQFbM1Xuk7
 uCG8/YnPzIsQHcbW3YhvnrtJOL4=
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 12:04:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13362

Hi all,

final call for features that should go into the next isar-cip-core
release. I'm planning to tag rc1 by the end of this week and aim for a
release maybe a week later.

Jan

