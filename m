Return-Path: <nikola@trifunovic.at>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0352C7EE30
	for <webhook@archiver.kernel.org>; Sun, 29 Jun 2025 10:26:49 +0000 (UTC)
Received: from smtprelay02.cix.at (smtprelay02.cix.at [152.53.47.8])
 by mx.groups.io with SMTP id smtpd.web10.14970.1751192803442389639
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Jun 2025 03:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=softfail (domain: trifunovic.at, ip: 152.53.47.8, mailfrom: nikola@trifunovic.at)
Received: from mail.viennacix.com (mail.viennacix.com [80.64.132.81])
	by smtprelay02.cix.at (OpenSMTPD) with ESMTP id 38d6cfd1
	for <cip-dev@lists.cip-project.org>;
	Sun, 29 Jun 2025 10:26:40 +0000 (UTC)
Received: (qmail 9818 invoked by uid 89); 29 Jun 2025 10:26:40 -0000
Received: from unknown (HELO mailproxy.viennacix.com) (nikola@trifunovic.at@152.53.46.111)
  by mail.viennacix.com with ESMTPA; 29 Jun 2025 10:26:40 -0000
Content-Type: multipart/alternative;
 boundary="------------1R10qk7iJxzcb0Xbu5tC72U5"
Message-ID: <4ed9cc33-0917-429e-a8fe-2cc43f5e87a3@trifunovic.at>
Date: Sun, 29 Jun 2025 12:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Troubles with isar build for bbb
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <c8233945-77ac-4a82-8016-f67a79054849@trifunovic.at>
 <61bd7c9a-b18e-44db-ac28-fb10941ed141@siemens.com>
 <90defef6-da71-4669-afd1-a1a5d180b802@trifunovic.at>
 <d8a6d28d-4d36-4b98-8142-8629e6c01f58@siemens.com>
Content-Language: de-AT, en-US
From: Nikola Trifunovic <nikola@trifunovic.at>
In-Reply-To: <d8a6d28d-4d36-4b98-8142-8629e6c01f58@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 29 Jun 2025 10:26:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19250

This is a multi-part message in MIME format.
--------------1R10qk7iJxzcb0Xbu5tC72U5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, and I forgot to mention, that I used for all builds the "Head of 
selected CIP kernel branch" option.

Let me know, if you need more information! I can make more build tests, 
if you need any.

Cheery,
Nikola



On 29.06.25 09:25, Jan Kiszka wrote:
> On 28.06.25 23:04, Nikola Trifunovic wrote:
>> Hello Jan,
>>
>> many thanks for the fix. The following build worked
>>
>>    * Kernel 5.10 with Buster
>>    * Kernel 6.1 with Buster
>>    * Kernel 6.1 with Bookworm
> But all of them only worked with the reverting patch below, none with
> vanilla isar-cip-core, right?
>
> Jan
>
>> Please find attached the boot log of the last combination.
>>
>> Cheers,
>> Nikola
>>
>>
>> On 22.06.25 20:51, Jan Kiszka via lists.cip-project.org wrote:
>>> Hi Nikola,
>>>
>>> On 20.06.25 23:37, Nikola Trifunovic wrote:
>>>> Hello,
>>>>
>>>> I am having trouble getting my BeagleBone Black to run with the 5.10
>>>> kernel and Buster distribution. The boot process ends with an ALERT in
>>>> initramfs. I have attached the boot log to this email.
>>>> I have tried two different builds, one with and one without the 'Head of
>>>> selected CIP kernel branch' option.
>>> Can you try without the part-uuid?
>>>
>>> diff --git a/wic/bbb.wks b/wic/bbb.wks
>>> index b46282dd..a797e95f 100644
>>> --- a/wic/bbb.wks
>>> +++ b/wic/bbb.wks
>>> @@ -9,6 +9,6 @@
>>>   part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
>>>   part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
>>>   
>>> -part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
>>> +part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
>>>   
>>>   bootloader --append "rootwait console=ttyO0,115200"
>>>
>>> If that allows to boot, please also check if kernel 6.1 (the latest one
>>> when that change was introduced) is working with --uuid and only our
>>> 5.10 (config) has an issue.
>>>
>>>> I followed the instructions athttps://gitlab.com/cip-project/cip-core/
>>>> isar-cip-core, but the only difference is that I do not have a *.img
>>>> file. The only file that looks like an image is "cip-core-image-cip-
>>>> core-buster-bbb.wic".
>>> Outdated README, indeed. Patch sent.
>>>
>>>> I assume that I am making a mistake or missing some steps.
>>> We unfortunately have no CI-driven image testing for the BeagleBone
>>> Black, and that might have allowed some regression to sneak in.
>>>
>>> Thanks,
>>> Jan
>>>
>>>
>>> -=-=-=-=-=-=-=-=-=-=-=-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#19158):https://lists.cip-project.org/g/cip-dev/message/19158
>>> Mute This Topic:https://lists.cip-project.org/mt/113750203/9398619
>>> Group Owner:cip-dev+owner@lists.cip-project.org
>>> Unsubscribe:https://lists.cip-project.org/g/cip-dev/unsub [nikola@trifunovic.at]
>>> -=-=-=-=-=-=-=-=-=-=-=-
>>>

--------------1R10qk7iJxzcb0Xbu5tC72U5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="Helvetica, Arial, sans-serif">Yes, and I forgot to
      mention, that I used for all builds the "Head of selected CIP
      kernel branch" option.<br>
      <br>
      Let me know, if you need more information! I can make more build
      tests, if you need any.<br>
      <br>
      Cheery,<br>
      Nikola<br>
      <br>
       <br>
    </font><br>
    <div class="moz-cite-prefix">On 29.06.25 09:25, Jan Kiszka wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:d8a6d28d-4d36-4b98-8142-8629e6c01f58@siemens.com">
      <pre wrap="" class="moz-quote-pre">On 28.06.25 23:04, Nikola Trifunovic wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hello Jan,

many thanks for the fix. The following build worked

  * Kernel 5.10 with Buster
  * Kernel 6.1 with Buster
  * Kernel 6.1 with Bookworm
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
But all of them only worked with the reverting patch below, none with
vanilla isar-cip-core, right?

Jan

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Please find attached the boot log of the last combination.

Cheers,
Nikola


On 22.06.25 20:51, Jan Kiszka via lists.cip-project.org wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Hi Nikola,

On 20.06.25 23:37, Nikola Trifunovic wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Hello,

I am having trouble getting my BeagleBone Black to run with the 5.10
kernel and Buster distribution. The boot process ends with an ALERT in
initramfs. I have attached the boot log to this email.
I have tried two different builds, one with and one without the 'Head of
selected CIP kernel branch' option.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Can you try without the part-uuid?

diff --git a/wic/bbb.wks b/wic/bbb.wks
index b46282dd..a797e95f 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -9,6 +9,6 @@
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
 
-part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
+part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
 
 bootloader --append "rootwait console=ttyO0,115200"

If that allows to boot, please also check if kernel 6.1 (the latest one 
when that change was introduced) is working with --uuid and only our 
5.10 (config) has an issue.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">I followed the instructions at <a class="moz-txt-link-freetext" href="https://gitlab.com/cip-project/cip-core/">https://gitlab.com/cip-project/cip-core/</a>
isar-cip-core, but the only difference is that I do not have a *.img
file. The only file that looks like an image is "cip-core-image-cip-
core-buster-bbb.wic".
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Outdated README, indeed. Patch sent.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">I assume that I am making a mistake or missing some steps.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">We unfortunately have no CI-driven image testing for the BeagleBone 
Black, and that might have allowed some regression to sneak in.

Thanks,
Jan


-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#19158): <a class="moz-txt-link-freetext" href="https://lists.cip-project.org/g/cip-dev/message/19158">https://lists.cip-project.org/g/cip-dev/message/19158</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.cip-project.org/mt/113750203/9398619">https://lists.cip-project.org/mt/113750203/9398619</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:cip-dev+owner@lists.cip-project.org">cip-dev+owner@lists.cip-project.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.cip-project.org/g/cip-dev/unsub">https://lists.cip-project.org/g/cip-dev/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:nikola@trifunovic.at">nikola@trifunovic.at</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------1R10qk7iJxzcb0Xbu5tC72U5--

