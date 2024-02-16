Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D993C48260
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 16:50:30 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.83])
 by mx.groups.io with SMTP id smtpd.web11.1685.1708102222097171435
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 08:50:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NnmRpAZG;
 spf=pass (domain: siemens.com, ip: 40.107.104.83, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mse/UgUACGdN3x4tA63JJrfc6ZhQDNkinHLD5w71t9QD9OzD3fFv0SCs/lcd6bVgRPz74BvCkgz0wdzptSD8Sy4o6jSPXM1CJlYhVKygnjy4HH0ZwdMaeijmLpUNpA8uyECg3prrl0rLsfsDxGZ2Oigxz0Bm43sTSSq5ARPlz9PCTTlTVk5wud4NpP8Bd6XQsbvjcH9IZDK//fJVOeIl22x7lnyjR6MBdDkHJIeMzKhMx7c5AnQrHzTlAydIYPkM13H3MUYrXKNZ78VjM/mdzi7sxTS0X7aqjKzAKXIcE4i8kbkf6AFBdiLvT/xaDxyQy7ZOb9oyBBrEDcW6ozF0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8ukRr+JOztd9SocFqngeHmZdcBpnYfwY4EuF6gt0nQ=;
 b=oN7p+fag88bF5SikvfNyXxycefHpjhPfcPZH42M/iCx4Sj1cN/Fs9ObTF+amsOzYLQzeQ9IdP3w5INelEFHR3G25v3nlqwwjCHgdq/KZyxWaR0IkH4orSiEieZUbkxN3NoFykrSDWuX7EmFitT4UaYZXTbqGDwfNrJ/K4xcS5HBKINS6XqNWgK/hy5CGMLcsRznWBVW8pNg5YA8IBJLX8AUf0+3AUnBkhvi4aiGalz+IM1fsLbkJaSEihIuiJlQ08i77BByd+qHl1psecRKZ569/vGg4NqWyr9cs8OwKYH2CrSpLKjTBXffXRJnvWfYQiEIVKmL9nzOCHj0IBTUdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8ukRr+JOztd9SocFqngeHmZdcBpnYfwY4EuF6gt0nQ=;
 b=NnmRpAZGtiGNo9yta//ekM4/MEx+tVcMO/FgWXvcEzcEilw1S/jX1V/VwmBx1qWUzGWXCIlOMn5HuSeaUMSIA8e/AT73kOSZ2J0MWjxFaPXfTum7xQAiekEWem3TkEIMwqJMsd+XURhNSNSgBD1scx5W6H07VqARJCPqoMxv3s6JVwHWEqGERaAJ1EqiJtdpG3XzfTOglR+XqjLeUziFMRP8bO0VCfZwMwShqk2fmVuri/4DjSTuPa0Y7YvYafRZ3byhXmEramwu+ciUA8mupru2Ftxxt3Ozn8f9hJ8YnHy15ZA77uVB+rkOtCyfI7iJcpohSzZ57BKG1ldkuCIyuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7797.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 16:50:19 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 16:50:19 +0000
Message-ID: <c891e1ce-d692-4e53-b280-55e777142747@siemens.com>
Date: Fri, 16 Feb 2024 17:50:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/4] doc/README.swupdate.md:
 Add documentation for hardware compatibility
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20240216153024.260416-1-Quirin.Gylstorff@siemens.com>
 <20240216153024.260416-5-Quirin.Gylstorff@siemens.com>
 <9be1412f-94d9-4c00-8e9c-6fa343ff17f2@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <9be1412f-94d9-4c00-8e9c-6fa343ff17f2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ae5539-c635-4026-a854-08dc2f0f5bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gQJGiM2cYZbnkJI+8so8kpsQTtkLUDzQxob30EulBLnqU4u0p1flDZQeNwH3gB+8RUL3NpeO1wQFGUhPuaI+v0rZSNJBfZg+wpvVP5tvF7OYHWXkpraGXrd9RZp6uMGPNMD/6a+tEu4TiHK0p/Ll2T3RY1CeCzQ2gCQJwnQFgcswx+6QeaRgVljkSO5yn6h9+DBsjeoqShkNsm79AI2/eqL8fDQqczEr3HjrywwCW30+WaWocHY5DLhkvc2eN4/ISYCUEjKZf/w2oyMhgrO23tAg3s/fZnWolpgdiYsD6Cz7EgiV/pTIWkIt4Ilr8ESDvJ+sxe77ZfAtnkjdbr+KaAWsrHHd29BCVENNH6nj2zdOjgOqbD8tMkObkBF1OGXgfIbFsCsTZcO8EOwSC8IrPJJOZVE0JrcGwk1l7VwdHKBgbQUlxiF9BXxR7ymjetmpufhtJCq8rVtQgyhOISFmiqntXQ5o/c0FyKA6+h6nZJfzA0Ft0IjJcTitKHRSKiAdNWSR9cZfhNoUt5RlpBGi1iJwzOQZIoaqBe3qH3wMYeY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(6512007)(6486002)(478600001)(31686004)(41300700001)(5660300002)(2906002)(8936002)(8676002)(6506007)(66476007)(53546011)(316002)(66556008)(66946007)(83380400001)(31696002)(86362001)(82960400001)(26005)(36756003)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?akF6SngrVExmNjQyTys1Y05jUk1IY1BuTVRLVkJNc0N3eThHZ25BQXJua3Y0?=
 =?utf-8?B?YnFUVFdKSEhDVkxHNFhBVms2Nk9obUltemFobWFBa3VBL2ptUWV6ZDJZcTQr?=
 =?utf-8?B?cGtBcUc0R3VDcVZsTFVNRWZneUEwdVVscjZMWUl6ZkxIRENhY2hlS29sMU5n?=
 =?utf-8?B?NnByeG1NWFNMbGNGMklJOUZLMW5YZnBKbEt0bStRZkFxVGQvRDZJUkxiUEFX?=
 =?utf-8?B?U0o4WkJaaVF1dEp1QWFoYlV6S1dpNGhsbkNSMStiWlp5UEk2OVJwLy9yakJB?=
 =?utf-8?B?V0Nkd0tkM1EzN2sxWmN2WEV6RldGdkt5Q294RWMrM1poSlNMUVIwZlFPQ0ZC?=
 =?utf-8?B?WFpKbHdQNWtJSHBjN25vSnhWNGk2cENLWlNqSEd5OEYxOGV2bHVJeWRjTVJp?=
 =?utf-8?B?R0ZlaVVEZ1hsTDBxMER0eGFDb0JQWElGRThYL3dDeUdSUmJlWjhCSHZCQVZP?=
 =?utf-8?B?Z3BsbWx0MDZzTGNGTStPTkRkalBNVkVWVC9lWEdsL28zYTJYY3U3RCtaYVo0?=
 =?utf-8?B?bWlwYU1LYk5lU0JiMUM4aGpSeWlSa3BMbUtLZG94RW56SkxCVmlDazVWeW1X?=
 =?utf-8?B?S1JJMW5YOVlCNUlZenhBcnpDb0s0aXJQSFhiSTlpRzFPNXJwc2hDdFFlMThN?=
 =?utf-8?B?SnBUMm5odXl3M1JsODJsZWVQMUtQem4rMTFvYkxJZDBQRExxUWh0bXRnMnpH?=
 =?utf-8?B?Qkswd0lrZFF6dVBEanFOWlhvRXVtRmNPbkRoWWVndlZMMVUzNk1sRWhBUXZB?=
 =?utf-8?B?d1BudXFjRHlCakRXMFZLbE9pZEhYTWFuYmpXVXFvZHFkemlrK2tsY3FPQlI3?=
 =?utf-8?B?emYvOW02eHdyVkZUOWdSS3VIaEtZTUZHQXR4cExPRURZRlU1TGhzYmdGUmVF?=
 =?utf-8?B?ME1uRjVqRllLYzZ3SUZEZC9UcTdacnJPMGtxa09ReWJka0dPR1lDWVlJdFRT?=
 =?utf-8?B?VlNkVXl2Z1VqV1NwWW9vaUNEalp4VEpnb21vaGpFakxhTFFKWDI3dGRRVEhl?=
 =?utf-8?B?a29OZEN3UmZ5NnNpSUtMdUlsR3ptbC9qVnoxYWNGRDd3bGFPZ1NHaGNFaXV3?=
 =?utf-8?B?cWZNbGhoVURhSmduRVAzN0dxdGRrbGphTFAvOVFCQnhoOVBBNDB6QTFGWmht?=
 =?utf-8?B?ekJ1SDN3MVh1UFpReUZ4RlcrUms3YzVZVjcyMzE3eTRBaklzb0FoR01kcE41?=
 =?utf-8?B?L1E0TGdmOEcwc1V3Tzg5NHlIcDk1cjdId1RSRGJSWFVDQzBtNUVhYkZ5UGdB?=
 =?utf-8?B?WGZGZTRzaVlUZDRNNElXc2U3cWkycnkxT2NkeExVbmg0ZmNGZEp1ZHFwZlg1?=
 =?utf-8?B?TncrUk01eWlwS2hVdEZQQTdIUkluR3YyaUpvdlYwWnBQYXFwQzdxMXI3SU4w?=
 =?utf-8?B?S1V4UWZ2NVFUS0FacVhud3VSaVRSMGl4ck1LQjBHY3BrWW41M0x5cjRuT21G?=
 =?utf-8?B?L0xsS0xPRTNDZ0M0bUJxeTY3WjdqTHZMNW9MSnZMQTBJSlM0QzRSc3dMa2U5?=
 =?utf-8?B?UE9CWUxDdUM2SWpveVV4Z3I5NkJ5eUx6MGRaRHRlNVN3RUxOME5kUC8ySjJk?=
 =?utf-8?B?eTA1ZHlDdU1EZmVBZWlHSmdJcXJ2U2YvR00zUVNsMjFvaGRhMUNXL0NONVVN?=
 =?utf-8?B?T3RMK2FZUStNVFVEUXlkMmVYZzdLN0UzZnB5UWgyQkE2bmpRcG5GUTljRWhE?=
 =?utf-8?B?bW9IcXFvS2thWjZYS1JxN2Vab3lUSnFlY0VWdk4raC9odDhwTW1pclAzbzNT?=
 =?utf-8?B?TVBVeFdpOHJLNGZrWURXTUJFSXUrcWsxdXRxYXRqN2UxaHhLMXMvU0NmZU1t?=
 =?utf-8?B?ZUhkYW5QclE5RGNzYVZuclNBc2lPWk9oQ2NsOHhpOWJkRm96OTA4UnhwYWUv?=
 =?utf-8?B?Uy9MdllYajVmaXRDQlB0YTAvUWtqSDBjMzFGUzJZY2cvcTBoakdkei9UcHc1?=
 =?utf-8?B?TU8rNUdlQm0vTngxSC9mZk5ZSE5KeExmQURFay9QRDJMMDJtTHY3d1ErNVhz?=
 =?utf-8?B?cVBJb3dWTmptNWRXcUZLOUpaUDZhV0pkYld2enRNck9hK0o5MkFDZGs5NkNJ?=
 =?utf-8?B?Rmg3UGJUaVhHWTVGb3d2ejlOcVdnNlFSN3U5bnN3WXF6VWFUUVQ5a0ZpbEp1?=
 =?utf-8?B?bitZdmhGbG9NakZiVi9PVnFHOUVjOXRwdit5cWJOenQ0bnF2QVpOZjEwVVRl?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ae5539-c635-4026-a854-08dc2f0f5bbe
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 16:50:19.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Vo9n90pS4mnWn3/fUHZdGpK/TirFunEyYQip4ppPUplHZXYZa+86cIYiumWlZqsT0PC4aRYp3J8hd624unrnzv34Jys95We53rH8M3WJoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7797
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 16:50:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15020



On 2/16/24 16:39, Jan Kiszka wrote:
> On 16.02.24 16:30, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   doc/README.swupdate.md | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>> index 1c94699..0f179c4 100644
>> --- a/doc/README.swupdate.md
>> +++ b/doc/README.swupdate.md
>> @@ -21,6 +21,16 @@ window is still possible.
>>   If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
>>   the `*.swu` file.
>>   
>> +## SWUpdate Hardware compatibility
>> +
>> +The variable `SWU_HW_COMPAT` contains a space separate list of
>> +compatible hardware revisions.
>> +SWUpdate checks the compatibility against `/etc/hwrevision`, see
>> +[hardware-compatibility in the SWUpdate documentation.](https://sbabic.github.io/swupdate/sw-description.html#hardware-compatibility)
>> +
>> +For testing purpose the content of `/etc/hwrevision` can be set with
>> +the variable `MACHINE_HW_VERSION`.
> 
> And what is the pattern to produce that file in production images?
> 
I would recommend to acquire an HW specific identifier(e.g. dmidecode ) 
during boot and write it to /etc/hwrevision.

I will add some text to the README.
Quirin

> Jan
> 
>> +
>>   # Building and testing the CIP Core image
>>   
>>   Set up `kas-container` as described in the [top-level README](../README.md).
> 

