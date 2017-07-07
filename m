From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 07 Jul 2017 09:00:35 +0100
Subject: [cip-dev] running health checks from behind a web proxy
In-Reply-To: <002c01d2f6b7$d0586df0$710949d0$@toshiba.co.jp> (Daniel
	Sangorrin's message of "Fri, 7 Jul 2017 09:27:28 +0900")
References: <87fueb6k6b.fsf@ctlt579.codethink.co.uk>
	<002c01d2f6b7$d0586df0$710949d0$@toshiba.co.jp>
Message-ID: <8760f47k2k.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Thanks - hope it works for you, hold off on closing that issue for the
moment, there's one other sub issue that I've just created a MR

https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/merge_requests/34

that needs addressing before it can be closed.

Robert

"Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp> writes:

> Thanks Robert, I will try today and see if it works.
> # I'll close the gitlab issue in that case.
>
>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Robert Marshall
>> Sent: Wednesday, July 05, 2017 11:19 PM
>> To: cip dev
>> Subject: [cip-dev] running health checks from behind a web proxy
>> 
>> There is a known issue with b at d when running a lava QEMU health check
>> from behind a web proxy.
>> 
>> When attempting to retrieve the kernel, it produces the error
>> 
>> Invalid job data:
>>   ["HTTPSConnectionPool(host='images.validation.linaro.org', port=443):
>>   Max retries exceeded with url: /kvm/standard/stretch-2.img.gz
>>    (Caused by NewConnectionError('<requests.packages.urllib3.connection.VerifiedHTTPSConnection
>>   object at 0x7f430c9b9c50>: Failed to establish a new connection: [Errno -5] No address associated with hostname',))"]
>> 
>> see:
>> https://gitlab.com/cip-project/cip-testing/testing/issues/99
>> 
>> As b at d is intended to use locally built artefacts and the default QEMU health
>> check uses a remote kernel, a suggested work around for this test would be to copy
>> https://images.validation.linaro.org/kvm/standard/stretch-2.img.gz
>> locally to /var/www/images/kernel-ci/qemu (a new directory)
>> and alter the health check to use the url
>> http://localhost:8010/qemu/stretch-2.img.gz
>> 
>> which should avoid the use of any web proxies.
>> 
>> You'll probably need a fairly clean copy of the VM with plenty of free
>> disk space to manage the extra copy of the kernel.
>> 
>> Thoughts? Hoping to discuss this further at tomorrow's open meeting.
>> 
>> Robert
>> _______________________________________________
>> cip-dev mailing list
>> cip-dev at lists.cip-project.org
>> https://lists.cip-project.org/mailman/listinfo/cip-dev
