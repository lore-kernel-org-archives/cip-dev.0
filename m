From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 3 Sep 2019 15:56:09 +0200
Subject: [cip-dev] [PATCH resend] arm64: dts: Remove inconsistent use of
 'arm, armv8' compatible string
In-Reply-To: <TY2PR01MB3243A1695F9A6BC6A5739BB792B90@TY2PR01MB3243.jpnprd01.prod.outlook.com>
References: <1567414102-4869-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<TY1PR01MB1770611703AA39BE5DCF14B8C0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<20190902090045.GD19557@amd>
	<TY1PR01MB17705F6AC65CC58C26429392C0BE0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<TY2PR01MB3243A1695F9A6BC6A5739BB792B90@TY2PR01MB3243.jpnprd01.prod.outlook.com>
Message-ID: <1137cd6d-4a85-8d19-a390-4aa539b8034f@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 03.09.19 06:45, nobuhiro1.iwamatsu at toshiba.co.jp wrote:
> Hi Fabrizio,
> 
> Thanks for your test.
> 
>> -----Original Message-----
>> From: Fabrizio Castro [mailto:fabrizio.castro at bp.renesas.com]
>> Sent: Monday, September 2, 2019 6:05 PM
>> To: Pavel Machek <pavel@denx.de>
>> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
>> <biju.das@bp.renesas.com>; iwamatsu nobuhiro(?? ?? ???????
>> ?) <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev at lists.cip-project.org
>> Subject: RE: [PATCH resend] arm64: dts: Remove inconsistent use of
>> 'arm,armv8' compatible string
>>
>> Hi Pavel,
>>
>> Thank you for the feedback!
>>
>>> From: Pavel Machek <pavel@denx.de>
>>> Sent: 02 September 2019 10:01
>>> Subject: Re: [PATCH resend] arm64: dts: Remove inconsistent use of
>>> 'arm,armv8' compatible string
>>>
>>> On Mon 2019-09-02 08:51:12, Fabrizio Castro wrote:
>>>> Hi Pavel,
>>>>
>>>> I have put you in CC (and kept the ML as recipient this time
>>>> around), did you receive the patch with or without the space?
>>>
>>> I got just one copy of email, and it does not have [cip-dev] marking,
>>> so I assume it is the direct one.
>>>
>>> No extra space.
>>
>> Then it's down to the mailing list, somehow, this same email reached the
>> ML, with a space...
>> https://lists.cip-project.org/pipermail/cip-dev/2019-September/00315
>> 8.html
>> https://patchwork.kernel.org/patch/11126171/
>>
> 
> Hmmm. There may be a problem in Mailman.
> 

Comparing the original patch (https://lore.kernel.org/linux-amlogic/20190109202934.29304-1-robh at kernel.org/raw) to ours:

X-Mailman-Version: 2.1.21 (looks fine)
X-Mailman-Version: 2.1.12 (our potentially broken version)

It looks like 2.1.21 is starting the wrapped around subject line only with a single space while our version gained a tab. The latter is likely the core if the issue. I would not expect this difference to be a configuration option of mailman, rather an issue in the older version

HTH,
Jan

>> Who is the person responsible for looking after the ML?
>>
> 
> Maybe Kobayashi-san. I just talked to him about this.
> Please wait a minute.
> 
>> Thanks,
>> Fab
> 
> Best regards,
>    Nobuhiro
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
