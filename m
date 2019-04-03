From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 3 Apr 2019 18:01:51 +0200
Subject: [cip-dev] [PATCH] start-qemu.sh: Set console when using
 qemu-amd64 with nographic
In-Reply-To: <TYAPR01MB249553FAC7B367A871344CF9D9570@TYAPR01MB2495.jpnprd01.prod.outlook.com>
References: <12bc282f-e95c-85a6-9919-674beb32fa13@siemens.com>
	<20190403083323.21613-1-akihiro27.suzuki@toshiba.co.jp>
	<20190403083323.21613-2-akihiro27.suzuki@toshiba.co.jp>
	<41182063-205c-eb38-2909-c90ed8e2bf38@siemens.com>
	<TYAPR01MB249553FAC7B367A871344CF9D9570@TYAPR01MB2495.jpnprd01.prod.outlook.com>
Message-ID: <212159cc-0a12-6869-c567-5e98485b0893@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 03.04.19 11:54, akihiro27.suzuki at toshiba.co.jp wrote:
> Hi Jan,
> 
>>> Signed-off-by: Akihiro Suzuki <akihiro27.suzuki@toshiba.co.jp>
>>> ---
>>>   start-qemu.sh | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/start-qemu.sh b/start-qemu.sh
>>> index b71ba32..46b7961 100755
>>> --- a/start-qemu.sh
>>> +++ b/start-qemu.sh
>>> @@ -83,8 +83,15 @@ fi
>>>
>>>   shift 1
>>>
>>> +QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} $@"
>>> +if [ -n "`echo ${QEMU_EXTRA_ARGS} | grep -- -nographic`" ]; then
>>> +	if [ ${DISTRO_ARCH} = "amd64" ]; then
>>> +		KERNEL_CMDLINE="${KERNEL_CMDLINE} console=ttyS0"
>>> +	fi
>>> +fi
>>> +
>>>   ${QEMU_PATH}${QEMU} \
>>>   	-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
>>>   	-m 1G -serial mon:stdio -netdev user,id=net \
>>>   	-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
>>> -	-initrd ${INITRD_FILE} ${QEMU_EXTRA_ARGS} "$@"
>>> +	-initrd ${INITRD_FILE} ${QEMU_EXTRA_ARGS}
>>>
>>
>> This is not what I meant. I was rather thinking of
>>
>> diff --git a/start-qemu.sh b/start-qemu.sh
>> index b71ba32..62522db 100755
>> --- a/start-qemu.sh
>> +++ b/start-qemu.sh
>> @@ -32,7 +32,7 @@ case "$1" in
>>   			-device ide-hd,drive=disk \
>>   			-device virtio-net-pci,netdev=net"
>>   		KERNEL_CMDLINE=" \
>> -			root=/dev/sda vga=0x305"
>> +			root=/dev/sda vga=0x305 console=ttyS0"
>>   		;;
>>   	arm64|aarch64)
>>   		DISTRO_ARCH=arm64
>>
>>
>> As mentioned before, there is no reason to confine this to -nographic
>> mode.
> 
> I'm sorry, I misunderstood.
> The changes you have shown are enough to solve the issue.
> Could you commit and push it for me instead?

Sure, patch pushed into next branch.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
