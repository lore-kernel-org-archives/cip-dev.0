From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Wed, 01 Nov 2017 10:23:05 +0000
Subject: [cip-dev] The health check test for BBB
In-Reply-To: <390B4EACA1A32748BA6BC7F859F7D7165D197C00@GSjpTKYDCembx31.service.hitachi.net>
	(=?utf-8?B?IuWwj+WPo+eQouWkqw==?= /
	=?utf-8?Q?KOGUCHI=EF=BC=8CTAKUO=22's?=
	message of "Tue, 31 Oct 2017 09:38:09 +0000")
References: <BC4DB242-B5E0-4A2E-8C59-A54E03398263@hitachi.com>
	<390B4EACA1A32748BA6BC7F859F7D7165D1929CF@GSjpTKYDCembx31.service.hitachi.net>
	<87y3nx2ebo.fsf@ctlt579.codethink.co.uk>
	<390B4EACA1A32748BA6BC7F859F7D7165D197C00@GSjpTKYDCembx31.service.hitachi.net>
Message-ID: <87shdypaba.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Takuo

"???? / KOGUCHI?TAKUO" <takuo.koguchi.sw@hitachi.com> writes:

> Robert,
>
> Thank you for the information.
> It seems my problem occurs earlier than waiting U-boot prompt.
> It says
> Send-reboot-commands: wait for prompt The system is going down for reboot NOW(timeout 00:02:00)
> But actual message is The system is going down NOW!
>
> Do you know where is Send-reboot-command is defined?
>

I think that if you change
/etc/lava-server/dispatcher-config/device-types/beaglebone-black.jinja2
adding the line
{% set shutdown_message = shutdown_message|default('The system is going down for reboot NOW!') %} 

it should work, but in view of that message not matching I expect that
the U-Boot prompt might well need adjusting too as below! 

> # Should I post this type of question to cip-dev ML?
>

Good idea - cc'ing there!

Robert

>
> Takuo
>
>
>> -----Original Message-----
>> From: Robert Marshall [mailto:robert.marshall at codethink.co.uk]
>> Sent: Friday, October 27, 2017 5:19 PM
>> To: KOGUCHI?TAKUO <takuo.koguchi.sw@hitachi.com>
>> Subject: [!]Re: The health check test for BBB
>> 
>> Takuo
>> 
>> I think the issue is probably due to the version of Debian/U-Boot on your
>> beaglebone if you look at
>> https://gitlab.com/cip-project/cip-testing/testing/issues/53
>> 
>> Boot your board with a telnet connection via ftdi and press any key at the start
>> of booting to get to U-Boot if the prompt is '=>' rather than 'U-Boot =>' you
>> need to adopt that solution and add a line
>> 
>> {% set bootloader_prompt = bootloader_prompt|default('=>') %}
>> 
>> to the device dictionary in
>> /etc/lava-server/dispatcher-config/device-types/beaglebone-black.jinja2
>> 
>> Robert
>> 
>> "???? / KOGUCHI?TAKUO" <takuo.koguchi.sw@hitachi.com> writes:
>> 
>> >
>> >
>> >
>> >
>> > Robert,
>> >
>> > Thank you for the advice.
>> > This time the health check test got started, but hit "Connection closed" error
>> at send-reboot-command.
>> > Probably "The system is going down" message is different from the expected.
>> > Will you tell me where the expected message is defined?
>> >
>> > Takuo Koguchi
>> >
>> > 2017/10/25 16:36?Robert Marshall <robert.marshall@codethink.co.uk> ???
>> ???:
>> >
>> >  Takuo
>> >
>> >  Good news on the kernelci front! For the health check you need to use
>> > the create-test.sh script mentioned on the test page on the wiki, you'll need
>> to  define TREE as you did for the build and run from the linux-cip directory.
>> >
>> >  Hope that works for you!
>> >
>> >  Robert
>> >
>> >  On 2017-10-25 16:16, ???? / KOGUCHI?TAKUO wrote:
>> >
>> >  Robert,
>> >
>> >  After I add default gw to NAT (eth0), build.py succeeded even on the hotel
>> wifi.
>> >
>> >  But the self check is failing. it seems the self check script cannot
>> >
>> >  find the files created by build.py at
>> >
>> >  localhost:8010/TREE/BRANCH/TAG/arm...
>> >
>> >  I will report if I make any progress.
>> >
>> >  Best regards,
>> >
>> >  Takuo Koguchi
>> >
>> >  2017/10/24 18:36?Robert Marshall <robert.marshall@codethink.co.uk> ??
>> ????:
>> >
>> >  Takuo
>> >
>> >  "???? / KOGUCHI?TAKUO" <takuo.koguchi.sw@hitachi.com> writes:
>> >
>> >  Dear Robert,
>> >
>> >  linux-cip build for kernelci fails in my case.
>> >
>> >  Should it work as in the way described in the web page?
>> >
>> >  Takuo Koguchi,
>> >
>> >  Hitachi, Ltd.
>> >
>> >  Clearly you've downloaded the cip kernel which is most of the way
>> > there,
>> >
>> >  though as I said this afternoon, the networking within the Vagrant VM
>> >
>> >  will not work on the conference or the hotel wifi.
>> >
>> >  What error did you get?
>> >
>> >  Robert
>> >
>> > *
>> >
>> > *
>> >
>> > iPhone????
