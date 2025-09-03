Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD51CA1012
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:13:38 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.14365.1756910585640391045
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 07:43:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=hJZLonVP;
 spf=pass (domain: linaro.org, ip: 209.85.218.43, mailfrom: jerome.forissier@linaro.org)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7ace3baso594664266b.3
        for <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756910584; x=1757515384; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4shK9EBnP1XTLra0+voq+VDSiZ3w8vJk2bGPz8ooVso=;
        b=hJZLonVPfiXLH8eN8klF1FnertLzADq9ZcY3l9sNl5w9IXN2Z8XoiOY0tec7uobFSS
         HfOYPe0Y9Y6G1L0baUTmDEV/EiN0S7G89n1guN7NNW5rmFbIotQrIZu8Rbq+H+uIa9QH
         OC8a26E57KBlG+7OlDxLJ5+8hC2dgAUN2/Ip09PLZUtm4E8bG/U+5E8zdiiUDRgKYgAv
         LeX3Poh1XzZAheRYwk1X+Foiq7H1J28wX/2cW8cg8032/U8YMs8zcePLRHtDyz6l1i49
         VuUHHGwqqIUKAeyY7FpfpN2PCqSu3OfM+KGUWn5U5mxvNMlMNp3l9LwtGU5QeDDIvWuD
         oFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910584; x=1757515384;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4shK9EBnP1XTLra0+voq+VDSiZ3w8vJk2bGPz8ooVso=;
        b=wfIhVIV/NXe4APOUF44BDU4i/JnVNkkwtJD5a0m26CFUfwUWh1iPYsEetUfrQHAAOh
         JfiHoLvtoXE9PGb0HsMIbSn8/xOkzQlInvpoiGuO55vGVuclPfXwfPrWv+bkga9xdktC
         SJkVd165gcIzcth77t751tGmhZ98tjIuDS8JNgNwk9jGbw8oqpaZ9IJXSqevQVGm75+1
         0CHKhLCHfe/YzL/gerRfIoCTOACAD4pKe5o8oJS8kLawQTbwYQK5Gf82yW88oUTco1bf
         7tnvo4rpN2bZfknWARkmfwyZYdOfJ3StQWd0EBnIE3tHOePkxtbTzP/wLtB5MLJ7uFsb
         t4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV0AjeoEU/csIdJ7/iL7d4B4GWMjm/UlwzAjLvWSlAJMWnFGnSAqo9tN/2e9+490aohYujK2cJ@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx2wbhNtd6TX8bbhORzUaVL2JgCtW+UI5N4638Bl4hTL4QE950o
	GHMgSBkG4MOOIq6oZ5gPI6nRabx8jgk6zZS52HHmPOHi6s8QrHRWqlvLGatL/BqjUcZkqzwziwQ
	9Dj2wOZSajQ==
X-Gm-Gg: ASbGncvbRfr/xkJjoUFaEFjVykwljVnAtPEZNe8ZSr9RbmfnprVv7IRi+1Gv084RoYa
	5A51HK9IPSOZeDs6HroHfW1y8WKPrIng4iU12N7FOl4nzFqCScuN61nVuU5DCEq6Ve+qpcxbQ2F
	R7k2mAEbfsjmmcvny5M70jcWJuG1jneug9JfcLdSCUntZbD+X7ZMaN5efnrnYDB1yPCCmXhCwPC
	exbp0ksA2WZbwGGrEeEaRTrkmDbwiunsvQitCZ7E2XkItvMA+3723DqLP21E83s+HzxebinEzyV
	Jnu1Dc3eY+uGgeB2W36tIGKQUqJd4CBqlTz1lrUX9GKyWelOY9vlqmOjh7GH02GPmYp7MWbB5lS
	MP68DK+88kzuEWj+ukhOAnStbZOImXm1dyx6nDRaY1QpxsZFHM5mLrZyne/iFtmK9p0EJdWm9CI
	zYv8OQISqHqg==
X-Google-Smtp-Source: AGHT+IFBTJJv/7sjdaQXVSAdJ4KduD6LWhTJFbzo19k/hpnMgGB0FeNaA69nzxx1+gq4eyHGDxdWRA==
X-Received: by 2002:a17:907:7f14:b0:b04:7107:9758 with SMTP id a640c23a62f3a-b047107c8famr141417266b.43.1756910146042;
        Wed, 03 Sep 2025 07:35:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:32e2:48f6:bf2:9a98? ([2a01:e0a:3cb:7bb0:32e2:48f6:bf2:9a98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff138a8d76sm1188241066b.104.2025.09.03.07.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:35:45 -0700 (PDT)
Message-ID: <6879f437-5a5c-4c24-942d-09220d801784@linaro.org>
Date: Wed, 3 Sep 2025 16:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] sd: Add RPMB emulation to eMMC model
To: Jan Kiszka <jan.kiszka@siemens.com>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
From: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 09:13:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20007

Hi Jan,

On 8/24/25 09:41, Jan Kiszka via OP-TEE wrote:
> FYI: QEMU model is working fine, upstreaming started, feedback welcome.

This is awesome. I pulled the various bits (QEMU v10.1.0 + your patches,
U-Boot next, Buildroot 2025.10-rc3 with mmc-utils v1.0) and was able to
run the OP-TEE OS tests successfully ("make check"), using the in-kernel
RPMB routing. TBH there is one failure with the TPM test (xtest
regression_1041) which I will need to figure out in due time but I am
already very happy with the situation. As soon as everything is upstream
I'll update the OP-TEE dev environment and add a job to the optee_os CI.

Many thanks for your work and for sharing it!

-- 
Jerome 

> 
> Jan
> 
> On 24.08.25 09:18, Jan Kiszka wrote:
>> This closes an old gap in system integration testing for the very
>> complex ARM firmware stacks by adding fairly advanced Replay Protected
>> Memory Block (RPMB) emulation to the eMMC device model. Key programming
>> and message authentication are working, so is the write counter. Known
>> users are happy with the result. What is missing, but not only for RPMB-
>> related registers, is state persistence across QEMU restarts. This is OK
>> at this stage for most test scenarios, though, and could still be added
>> later on.
>>
>> What can already be done with it is demonstrated in the WIP branch of
>> isar-cip-core at [1]: TF-A + OP-TEE + StandaloneMM TA + fTPM TA, used by
>> U-Boot and Linux for UEFI variable storage and TPM scenarios. If you
>> want to try: build qemu-arm64 target for trixie with 6.12-cip *head*
>> kernel, enable secure boot and disk encryption, then run
>>
>> $ QEMU_PATH=/path/to/qemu-build/ ./start-qemu.sh
>>
>> Deploy snakeoil keys into PK, KEK and db after first boot to enable
>> secure booting:
>>
>> root@demo:~# cert-to-efi-sig-list PkKek-1-snakeoil.pem PK.esl
>> root@demo:~# sign-efi-sig-list -k PkKek-1-snakeoil.key -c PkKek-1-snakeoil.pem PK PK.esl PK.auth
>> root@demo:~# efi-updatevar -f PK.auth db
>> root@demo:~# efi-updatevar -f PK.auth KEK
>> root@demo:~# efi-updatevar -f PK.auth PK
>>
>> Note that emulation is a bit slow in general, and specifically the
>> partition encryption on first boot is taking 20 min. - we should
>> probably reduce its size or understand if there is still something to
>> optimize.
>>
>> Jan
>>
>> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/qemu-rpmb
>>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>>
>> Jan Kiszka (8):
>>   hw/sd/sdcard: Fix size check for backing block image
>>   hw/sd/sdcard: Add validation for boot-partition-size
>>   hw/sd/sdcard: Allow user-instantiated eMMC
>>   hw/sd/sdcard: Refactor sd_bootpart_offset
>>   hw/sd/sdcard: Add basic support for RPMB partition
>>   crypto/hmac: Allow to build hmac over multiple
>>     qcrypto_gnutls_hmac_bytes[v] calls
>>   hw/sd/sdcard: Handle RPMB MAC field
>>   scripts: Add helper script to generate eMMC block device images
>>
>>  crypto/hmac-gcrypt.c   |   4 +-
>>  crypto/hmac-glib.c     |   4 +-
>>  crypto/hmac-gnutls.c   |   4 +-
>>  crypto/hmac-nettle.c   |   4 +-
>>  hw/sd/sd.c             | 314 ++++++++++++++++++++++++++++++++++++++---
>>  hw/sd/sdmmc-internal.h |  24 +++-
>>  hw/sd/trace-events     |   2 +
>>  include/crypto/hmac.h  |  12 ++
>>  scripts/mkemmc.sh      | 185 ++++++++++++++++++++++++
>>  9 files changed, 530 insertions(+), 23 deletions(-)
>>  create mode 100755 scripts/mkemmc.sh
>>
> 

