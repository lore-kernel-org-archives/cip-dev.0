From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Fri, 2 Aug 2019 12:34:29 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip-rt] Update CI to use the latest
 linux-cip-ci containers
In-Reply-To: <OSAPR01MB3234A53C3F58EBE0DE77510492DE0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <20190731220244.20321-1-chris.paterson2@renesas.com>
	<OSAPR01MB3234A53C3F58EBE0DE77510492DE0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <464a9666-97a5-3856-d815-de783543f6c6@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 02.08.19 01:30, nobuhiro1.iwamatsu at toshiba.co.jp wrote:
> Hi Chris,
> 
>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org
>> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Chris
>> Paterson
>> Sent: Thursday, August 1, 2019 7:03 AM
>> To: cip-dev at lists.cip-project.org
>> Subject: [cip-dev] [PATCH 4.19.y-cip-rt] Update CI to use the latest
>> linux-cip-ci containers
>>
>> The main aim of this update is to add support for more build architectures.
>>
>> In addition, we need to include a fix so that builds using Kernel configs
>> from cip-kernel-config will work again, after changes to the directory
>> structure caused us problems.
>>
>> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> 
> 
> Applied, thanks.

My stomach says that maintaining details of our CI infrastructure inside our
kernel tree is not the optimal approach. We will end up with a constantly
increasing number of fairly specific, non-kernel commits this way.

But that's just my impressions.

Jan

> 
> Best regards,
>   Nobuhiro
> 
> 
>> ---
>>  .gitlab-ci.yml | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml index
>> 96eed0e0c81a..fb775f4950b1 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -2,16 +2,17 @@ variables:
>>    GIT_STRATEGY: clone
>>    GIT_DEPTH: 10
>>    DOCKER_DRIVER: overlay2
>> +  DOCKER_IMAGE_TAG: v2
>>
>> -build_arm_renesas_shmobile_defconfig:
>> +arm_renesas_shmobile_defconfig:
>>    stage: build
>> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
>> +  image:
>> +
>> registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_
>> TA
>> + G
>>    variables:
>>      BUILD_ARCH: arm
>>      CONFIG: renesas_shmobile_defconfig
>>      CONFIG_LOC: cip-kernel-config
>>      DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
>> -    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
>> arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
>> +    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb
>> + r8a7745-iwg22d-sodimm-dbhd-ca.dtb
>>    script:
>>      - /opt/build_kernel.sh
>>    artifacts:
>> @@ -20,15 +21,15 @@ build_arm_renesas_shmobile_defconfig:
>>      paths:
>>        - output
>>
>> -build_arm64_renesas_defconfig:
>> +arm64_renesas_defconfig:
>>    stage: build
>> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
>> +  image:
>> +
>> registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_
>> TA
>> + G
>>    variables:
>>      BUILD_ARCH: arm64
>>      CONFIG: renesas_defconfig
>>      CONFIG_LOC: cip-kernel-config
>>      DEVICES: r8a774c0-ek874
>> -    DTBS: arch/arm64/boot/dts/renesas/r8a774c0-ek874.dtb
>> +    DTBS: r8a774c0-ek874.dtb
>>    script:
>>      - /opt/build_kernel.sh
>>    artifacts:
>> @@ -37,15 +38,15 @@ build_arm64_renesas_defconfig:
>>      paths:
>>        - output
>>
>> -build_arm_shmobile_defconfig:
>> +arm_shmobile_defconfig:
>>    stage: build
>> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:build-v1
>> +  image:
>> +
>> registry.gitlab.com/cip-playground/linux-cip-ci:build-$DOCKER_IMAGE_
>> TA
>> + G
>>    variables:
>>      BUILD_ARCH: arm
>>      CONFIG: shmobile_defconfig
>>      CONFIG_LOC: intree
>>      DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
>> -    DTBS: arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
>> arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb
>> +    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb
>> + r8a7745-iwg22d-sodimm-dbhd-ca.dtb
>>    script:
>>      - /opt/build_kernel.sh
>>    artifacts:
>> @@ -56,10 +57,11 @@ build_arm_shmobile_defconfig:
>>
>>  run_tests:
>>    stage: test
>> -  image: registry.gitlab.com/cip-playground/linux-cip-ci:test-v1
>> +  image:
>> +
>> registry.gitlab.com/cip-playground/linux-cip-ci:test-$DOCKER_IMAGE_T
>> AG
>>    when: always
>>    variables:
>>      GIT_STRATEGY: none
>> +    TEST_TIMEOUT: 30
>>    script:
>>      - /opt/submit_tests.sh
>>    artifacts:
>> --
>> 2.17.1
>>
>> _______________________________________________
>> cip-dev mailing list
>> cip-dev at lists.cip-project.org
>> https://lists.cip-project.org/mailman/listinfo/cip-dev
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
