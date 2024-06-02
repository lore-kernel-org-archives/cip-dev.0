Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58571C25B74
	for <webhook@archiver.kernel.org>; Sun,  2 Jun 2024 14:27:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.59697.1717338425147165179
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jun 2024 07:27:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 452ER2Pf3876970; Sun, 2 Jun 2024 23:27:03 +0900
X-Iguazu-Qid: 2yAbfjWaldOADISIls
X-Iguazu-QSIG: v=2; s=0; t=1717338422; q=2yAbfjWaldOADISIls; m=GsM0EV0j7l90owYUMixbO+GK4S2z5thhhx71JWmIng0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 452ER1Ie3643119
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 23:27:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv2/uvIafx4EiJ9bvD290vPqtyLFt9LPHybizBh5PhHyoEo41rSHGtBAMtmwwnuL8Qa3R0emIAQExdZhkA1QpHLMhKjB1nSadujreb7PnrZfKqEJ1fPk5gcn3h+W1oydiF5AGMsDwo2TO/FUIeFECuGp+ijao1flqC8rqM3RBGYL0NCw428trm9Uf6v+b+XOB+Nw4IBXgIH8d5nmfGIjBq/HnNfDDjacgLUjwkXjbNuh20J8Dol2mjJftFgJ2jFy6F+rKg2F7w2j7EidhMYIfjy0vy5ebWT7jc3SQXmCKY4UrVbGwlrGilaOoL+0e7P8e88uAtgEVOrDii9ibA+FIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50PPAmAraOHsLeOufHKIocLCrbfmpLMnIzOjxKPggys=;
 b=MQ35WQdKACKScebkGFYpRjZGlupJJgGsk0oApbSAfj4mPpuB7W8xisbhW1Qx0repzLA4O8ufLH+6Jb4+30G2g00NY/Ec4FfQ4ZTHP0GUoroYLl1iJAwFjgKeKz6vO+rtNeiBREuN93aWRDLCabOTqoLjMr0D4sx7gywiXKW1woDTcUU/iEKTWoBftf+JuThy6OnSw4VcBLjgiYN2r6p2iXpBJhHD4RCyjnvv/hYFrl6fYXPtNq1MkJYUBd7V3jV0Drh73sa9+1b7+omFGwqPuEnwXFtNo5KZr/9f+p85o10NGih5n4w8Z0zm1oeNq3guIPcyBFGwhH2qdiboRmc6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: Preparing test evidences for CIP Core packages for IEC 62443-4-x
 assessment
Thread-Topic: Preparing test evidences for CIP Core packages for IEC 62443-4-x
 assessment
Thread-Index: AdqngyKNF2gl+sOgQmW8Zvoy0bqzgANdasWw
Date: Sun, 2 Jun 2024 14:26:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96695706DE27A0CADA000C27C4FE2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <17CFF53CC1142B4C.16299@lists.cip-project.org>
In-Reply-To: <17CFF53CC1142B4C.16299@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYCPR01MB10462:EE_
x-ms-office365-filtering-correlation-id: 5a2963e2-3753-4063-90b5-08dc8310102e
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dXgzWG5jbnhPRFFBZDhzTUhBcE9NalJxMnFIeGhlcXZueS9wT3RhaXZ6?=
 =?iso-2022-jp?B?S2orVm94Vk9Mak52dm9wT2s2S0orWCs4VU1KR214QVRsdXlmb2NqQ1Js?=
 =?iso-2022-jp?B?eG1oR1JLa3pvdFE1NUlOSm5hUjFxdEVvemxTZ0xTVHM2T0Z4a0VaRjly?=
 =?iso-2022-jp?B?WGovalAyVVRvN3NhL01MaWlMZWNDOW9NZG1xenBzOEgzbE45VUFLNGF3?=
 =?iso-2022-jp?B?NzVCQTFUUStxeERIOXp6V3ZGYmtWanhONHYwdlMrNkZ0QW1qa1A3MFNI?=
 =?iso-2022-jp?B?QkxWQjVvZzFtZXpOWVpJUGZ6NTlGNnBnK2lzdlBIODdQRnRoUFpnaDJV?=
 =?iso-2022-jp?B?cXo4OUc0UWhmNzgySHhCUmkyWSs5UC9hVGp5azFoajZ6Y2I5MGhYU1Uy?=
 =?iso-2022-jp?B?aFJlR0l5cHVjT3NJN002ZVFCQWN6Q3FoRjlibzRRUWkwOUtaMFVWR3pG?=
 =?iso-2022-jp?B?Vzlaa09lRlZNaEdsdGo1bFhZM2V3TUxEc1JNcHZ6SW1Uc1E5MUZwTmxv?=
 =?iso-2022-jp?B?b3ZGMFBGd3YzMHBGRDVVMktTSkZaYXJnVXpBcGt5SS84U2UvcWM4ZVlp?=
 =?iso-2022-jp?B?cHZuTWoxMm4xczZqL3M0czVjbTh3cmZuT3J3TENWNGVYTENmdkx3WFFH?=
 =?iso-2022-jp?B?cXdpa3hRSHNqZlE4MDZaRWtmU0cxODdvMFVSK1dMVzRYMGxVUEV5ckh5?=
 =?iso-2022-jp?B?Znp5dUpPWUJHME1pWDhVQ3NpN1JyUzZmVi9oRUhIYTQyQVRxbWk0Wmxv?=
 =?iso-2022-jp?B?bnYxZmt3MERTQzMvOGFBN3BXZTZrKy9zcXBFZUUvejRzZ1dUbmwrdXZl?=
 =?iso-2022-jp?B?SnpsRHRJcStpYWkwNnpBNExqbzZ0THZIOUJtK1NmQkhSSmc5N0lJdE5p?=
 =?iso-2022-jp?B?OUR1NlNjSWpZRkZ1czR5aUV5OHNQZHdjWVlYOGxkbGRROFlzQm9SQS9G?=
 =?iso-2022-jp?B?OWN2MnhjdVRBMGk4VktNOUMrNlZGNHhpc0dRY1A1UDlicW9yTU9BejRv?=
 =?iso-2022-jp?B?UlRDTEJWYjhjTFkrWVdOSUdjU2J3eHY1Ung1bWN6ZHJSQnQ1ckV4Q3pp?=
 =?iso-2022-jp?B?NEV5cjFJSi90b0k3dkNnY0NqeUdPbTl0YVBYWk5iRnhkd3JIZkprVEwy?=
 =?iso-2022-jp?B?bUFIOVdPOVFPbEFlZG84cDNFMjg1bGYwbGJwMDBXQ0Y0cXZ4cnowZXUr?=
 =?iso-2022-jp?B?OEhLWHU5WmliN0hSek1lMFA2eS9SZStTa0RDYW1PZkxRQkdPNE9xaDZD?=
 =?iso-2022-jp?B?MlNxTFJDK2d1dzJ4bTRHWmNFempGN3N0M1pNcE5xa1dhVEhsTldXaUxj?=
 =?iso-2022-jp?B?VGFKdHBUbnU2MXBuL3E4MnhIdE53VDBzKy9PRmlaY0MxcmxVQjhCT1JS?=
 =?iso-2022-jp?B?cGg4a1o1T3NzRlpSVjBuWFcvQnRWWFYrY1BhVTlzbmpKZUEvV3JURTRY?=
 =?iso-2022-jp?B?bTRwU2hoN1Nyam01K25IdDdYSVVKVmoyMWFiV3lYejBvcEErODJvTWVO?=
 =?iso-2022-jp?B?L1JpOTY0ZXJxNGJxZEgwbnRFK0NUZjZrZUo1WFVDbjVCalluNzljdGVm?=
 =?iso-2022-jp?B?TUV6L3BNY2tnVHprYnQ5aW1yZmpVZ1B5WkxOU1hMVkVlQzV0QnpqWTRF?=
 =?iso-2022-jp?B?aURHdHBYanBXaGdpa3lGWHBQd1J3VHF2YmFaeEIvblNwQWM2YlNsNklL?=
 =?iso-2022-jp?B?ZVA5NEJhUUlkRURtcFlGemJPUWlHSWFPWnhTRnc0RWJ3dWdBQnF5YkUv?=
 =?iso-2022-jp?B?TmhhNXppeHU3MDNSQ1Z1dkVIM0VyUm5DSDQxNjJ3VDFpZ2ZTOCtDRG5r?=
 =?iso-2022-jp?B?WjZXQUxxelZncUtsZ0xsL3dJOC83cTRWRVFKQ1JZQTFmMlRUSW5mN3dn?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QktsNE5QTVNpQUlTYU9SR2ptK0kvMzlvdUJBbUtrQXIzVmwvd0M5YmdL?=
 =?iso-2022-jp?B?QUdXWE50aGZpMjQ2eUcxemRqaXZEemk1QWhxVHFLVkNnN21qQkNpNFJo?=
 =?iso-2022-jp?B?aC84QVNTNkV4TzNtN1VOQzNOYWhScUNsZW9MdStBbFhSS2pDcjV6ZFRw?=
 =?iso-2022-jp?B?SGVJQWRHOTI4OXNzNXc1ZmJJbDZZN2p6ek1GbDdXWmhRWjdoR0ZBQUN2?=
 =?iso-2022-jp?B?aFhrNjFjcjJmV1E5UjB0Y2hmamlyanl5Qms2cmhrUVRIYzhQQUh0QU94?=
 =?iso-2022-jp?B?U2NxUngzVGlmYjFFZnBzWVRYbVY0YkZISXZWUkNneUVOYWFSeHpQUkJo?=
 =?iso-2022-jp?B?cHdHbU5UNmxLWUxhUUk2ME94NmY1TEl0UThNSjJlbHVVWjJCNVprVm1s?=
 =?iso-2022-jp?B?Q3VRdkdnNGhPVEZqbW5NNWJvMHNSUzBzUU9nNFBoSURoRnk0YVhuMlJF?=
 =?iso-2022-jp?B?VUtobVJIYVZDTDFVTzI4WENpdllndFp3MjJ6UEJYdnMrYUpHZWd4VnZp?=
 =?iso-2022-jp?B?NDVoZ2tMRFU0M2N2U3lZUFdUcmhKcUNCNERUL2VjL3VGenlrUVVXb0Js?=
 =?iso-2022-jp?B?dkdveWpCVHVvVzdvN1Y3RS9UMUJUdjZIWFc4YzFXOGpOMTZCSnNLRHM1?=
 =?iso-2022-jp?B?MEs1b3c3dWJoL2ZEM2o5RWUzdWcrNEVHbnh1ZlBqQXdPT3NacHllRFBM?=
 =?iso-2022-jp?B?NERDYzZodlVRZ3NFNWpueEVsaXp1TVcvSCtseitoZSt1VDZiNGxJMFVt?=
 =?iso-2022-jp?B?T2w2YlU4R0pMWCtJeG1EVDBTVXNwbjRRWFpmNlhPRHU4dUFnUFY1RERZ?=
 =?iso-2022-jp?B?T0kzTmIxL0Q0K3hkRlE0clgzMWtVK0FuakpyaWw5Y0Rydnk2T2FsUGI0?=
 =?iso-2022-jp?B?TnlKdjRSdmVhcC9lRnJkcGQxZkQ4YVBNNzN4U2NxVy9DY2FxTGltVnh1?=
 =?iso-2022-jp?B?c0dSMm5ONS8zb0JNYVRHQWZabG4xRTRENllDVStUM3F2Mm94dzBNa3d5?=
 =?iso-2022-jp?B?b3FmOE15b2taUnVZVnYzZ1ZzcmNVTGZmQytHQWxGUG54OWJzUUQ1MExv?=
 =?iso-2022-jp?B?RDM5ZFMzSFhRcFoydlV0MXh5NURFeU9DSTRXNktpM01BMzBVSmxvZ2N2?=
 =?iso-2022-jp?B?NUlFbkZTcDVlOFc3bS80eGNtajYycHlrc1IzcEo3aDR4MDdNWjFhSXAz?=
 =?iso-2022-jp?B?UnVGQVd0YURTalBJTXQwaFFzZCszTU12bWtKYXY3cVRYK2wyRXFwVFda?=
 =?iso-2022-jp?B?TWxkVmZ0QktjSzRKc2FOdmNQM1RSWExvaVcwMThjbDlNVGJtYUtoSmhB?=
 =?iso-2022-jp?B?ZG94RUJma3UrVEdvOEdDTzE5bUF4eWVlazkrRng4eXNPMHNhNXdLNHhk?=
 =?iso-2022-jp?B?VEI5c1R6SmMwTmxGWVh0TjNlNmhLZ1hkaFQyVStSSUgyU2NERFpnaWs2?=
 =?iso-2022-jp?B?cFZ3SnJtd3FXUFI3TC9Ta0VMVkFEc0J2eDlkeFJmMXF1TDl1bjJZejhJ?=
 =?iso-2022-jp?B?U2NFb0p6ZlkwUkltSy9pZWx4SUlVZ3VsRmxETVpndWthSE1nUUVvNFp3?=
 =?iso-2022-jp?B?ZnFVdllvb2VWMFk2WFlwRHBrSDZxSVkwQnZnYmczVEVEbzM1VCtiSmt6?=
 =?iso-2022-jp?B?WTlPbS9nbERaSDhJdU5ZU1pqd3hWckdKT0dyMDU4UktNcGh0cGIwUFpL?=
 =?iso-2022-jp?B?aWQ0MFpRVWJqZmJHcitpcGRHZk5adkw5K1ZFM0tZN2w4ZWRNYklDdUlp?=
 =?iso-2022-jp?B?Y3ZJVHJ6anE3UThMWHVLc1o1dXhIWm5xcmFtNlZzNjBaVis4N2l4WW8z?=
 =?iso-2022-jp?B?VUo4bzUvdDdPc0dReTR6UFQ5NWREM1k3bklLS0V0SERoc0xvenc4aTFy?=
 =?iso-2022-jp?B?Rkc1amVMeU41M0MwbjZDZjZWS3Q4MEVFQ0tWR25GSHAwMG52N3ErT3dk?=
 =?iso-2022-jp?B?QnN4SDljMkNYSnZZVDM0VVpqYnlVRmNHL29kVGZrV3RiTUswWFd1Y1Jo?=
 =?iso-2022-jp?B?RkFDRWs4bCt0SjBmZFlWUEttZEdaZWtNWFpaZTBONXR6Z1hhem95TEUr?=
 =?iso-2022-jp?B?TkxHNXUwMjdBMEEwT3FHcjJYajZoZ1pSTzdlNmRNaklnelVvajduckVI?=
 =?iso-2022-jp?B?Tm9xZm5VdlUydk1nLzhwZUNPU1N6VEFFZjVHUlg1Wkh0bmNsYTEzQ1dr?=
 =?iso-2022-jp?B?cURjZVFBK24rb0hSTTU5UDFhSm5NeExJdmozOG1BdHppK1ZLeEx3Sy9k?=
 =?iso-2022-jp?B?NlN2UU1saWFuUWlWOVB6S3J5TitCLzRIcmFvc3d6TFRwU00rL05WODVh?=
 =?iso-2022-jp?B?MWRsd0lJYmlZbHc5NVFIUU0xOXpPajEwWTRsVVhwbzQrTCtEZCtnLzhz?=
 =?iso-2022-jp?B?dlNML0U9?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB96695706DE27A0CADA000C27C4FE2TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2963e2-3753-4063-90b5-08dc8310102e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2024 14:26:59.3890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuydggpOCQrtXoAxt/FOQJFsldFB9t0xPjAm3sBWOxWNl3zJwIuBT++6TBfGSqZd2L/RTlY5s79uVAIvLztj6WMldMlU97Ch687wbeqr+hmPJlGtw+U4CWHZl5OXoyA1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10462
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 02 Jun 2024 14:27:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16079

--_000_TYCPR01MB96695706DE27A0CADA000C27C4FE2TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Iwamatsu-san,

Sorry to bother you again.

Just wanted to follow up on the previous mail regarding the test evidences =
for CIP Core packages.
Would like to know if you have any suggestions on which other distributions=
 to look into for packages that do not have tests defined in Debian Salsa o=
r upstream.

Thanks and Regards,
Adithya Balakumar

From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Adithya Balakumar
Sent: Thursday, May 16, 2024 5:10 PM
To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T=
!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] Preparing test evidences for CIP Core packages for IEC 6=
2443-4-x assessment

Hello Iwamatsu-san,

Hope this message finds you well.

We at the CIP Security Workgroup have been working to collect test evidence=
s for CIP Core packages included in CIP Security image as part of IEC 62443=
-4-x assessment.

To summarize the work done by CIP SWG so far, CIP SWG investigated the numb=
er of packages in CIP Security image and tried to understand the number of =
packages that have test results available in debian and number of packages =
for which we have to run the tests ourselves and provide the results. I am =
including the summary of the packages below:


*         Total packages in CIP Security image - 242


*         Custom CIP packages (from isar-cip-core recipes) - 13

o   These packages are created by recipes in isar-cip-core or isar that are=
 deployed into image as a .deb file.


*         Packages with Debian CI autopkgtest - 140

o   97 packages with functional tests, 41 packages with non-functional test=
s, 2 packages with no tests running in debian CI


*         Packages without tests in Debian CI - 89

o   70 packages have tests available either in debian salsa or upstream.


*         Packages without tests in upstream as well - 19

There are a few packages that do not have tests defined in either debian sa=
lsa or upstream. I am listing the packages that do not have tests defined i=
n either debian salsa or upstream below:

Binary Package name
Source package name
Are there Debian CI results ?
Are upstream tests available
Remarks
base-files
base-files
NO
NO

base-passwd
base-passwd
NO
NO

hostname
hostname
NO
NO

libmnl0
libmnl
NO
NO

libnsl2
libnsl
NO
NO

libpam-passwdqc
passwdqc
NO
NO

libpam-pkcs11
pam-pkcs11
NO
NO

libpasswdqc1
passwdqc
NO
NO

libpython3-stdlib
python3-defaults
NO
NO

libreadline8
readline
NO
NO

librtmp1
rtmpdump
NO
NO

linux-base
linux-base
NO
NO

media-types
media-types
NO
NO

net-tools
net-tools
NO
NO
Few functional tests in ubuntu: https://git.launchpad.net/ubuntu/+source/ne=
t-tools/tree/debian/tests
Autopkgtest running in Ubuntu CI https://autopkgtest.ubuntu.com/packages/ne=
t-tools<https://git.launchpad.net/ubuntu/+source/net-tools/tree/debian/test=
s>
python3
python3-defaults
NO
NO

python3-minimal
python3-defaults
NO
NO

readline-common
readline
NO
NO

sysvinit-utils
sysvinit
NO
NO

tpm-udev
tpm-udev
NO
NO


As suggested by you in the previous TSC meeting, we are looking for any tes=
ts available for the above packages in other distributions as well. So far,=
 we have checked ubuntu, where we found a test suite for the net-tools pack=
age. The rest of the packages do not have tests defined in ubuntu as well.

We would like to understand your opinion on the next steps to take or other=
 distributions to target for tests for the above listed packages.

Thanks and Regards,
Adithya Balakumar


--_000_TYCPR01MB96695706DE27A0CADA000C27C4FE2TYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:52119350;
	mso-list-template-ids:1587441870;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1
	{mso-list-id:215094890;
	mso-list-type:hybrid;
	mso-list-template-ids:633612152 67698689 67698691 67698693 67698689 676986=
91 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2
	{mso-list-id:378015779;
	mso-list-template-ids:1621655554;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3
	{mso-list-id:684526932;
	mso-list-template-ids:130457480;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4
	{mso-list-id:711268500;
	mso-list-template-ids:1037707122;}
@list l4:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l4:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5
	{mso-list-id:1305353157;
	mso-list-template-ids:-251336644;}
@list l5:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l5:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l5:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Iwa=
matsu-san,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sorry to =
bother you again.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Just want=
ed to follow up on the previous mail regarding the test evidences for CIP C=
ore packages.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Would lik=
e to know if you have any suggestions on which other distributions to look =
into for packages that do not have tests defined in Debian Salsa or upstrea=
m.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Adithya B=
alakumar<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><b><span style=3D"font-fa=
mily:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language=
:ZH-TW">From:</span></b><span style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:ZH-TW"> cip-dev@lists.cip-pr=
oject.org
 &lt;cip-dev@lists.cip-project.org&gt; <b>On Behalf Of </b>Adithya Balakuma=
r<br>
<b>Sent:</b> Thursday, May 16, 2024 5:10 PM<br>
<b>To:</b> iwamatsu nobuhiro(</span><span lang=3D"ZH-TW" style=3D"font-fami=
ly:&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-language:ZH-TW=
">=1B$B4d>>=1B(B</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">
</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,serif=
;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$B?.MN=1B(B</span><span =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-=
fareast-language:ZH-TW"> =1B$B!{=1B(B</span><span lang=3D"ZH-TW" style=3D"f=
ont-family:&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-langua=
ge:ZH-TW">=1B$B#D#I#T#C=1B(B</span><span style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$B""=1B=
(B</span><span lang=3D"ZH-TW" style=3D"font-family:&quot;PMingLiU&quot;,ser=
if;mso-ligatures:none;mso-fareast-language:ZH-TW">=1B$B#D#I#T=1B(B</span><s=
pan style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;=
mso-fareast-language:ZH-TW">=1B$B!{=1B(B</span><span lang=3D"ZH-TW" style=
=3D"font-family:&quot;PMingLiU&quot;,serif;mso-ligatures:none;mso-fareast-l=
anguage:ZH-TW">=1B$B#O#S#T=1B(B</span><span style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:ZH-TW">)
 &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org<br>
<b>Subject:</b> [cip-dev] Preparing test evidences for CIP Core packages fo=
r IEC 62443-4-x assessment<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Hello Iwamatsu-san,<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Hope this message finds y=
ou well.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">We at the CIP Security Wo=
rkgroup have been working to collect test evidences for CIP Core packages i=
ncluded in CIP Security image as part of IEC 62443-4-x assessment.<o:p></o:=
p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">To summarize the work don=
e by CIP SWG so far, CIP SWG investigated the number of packages in CIP Sec=
urity image and tried to understand the number of packages that have test r=
esults available in debian and number
 of packages for which we have to run the tests ourselves and provide the r=
esults. I am including the summary of the packages below:<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l1 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol"><span style=3D"mso-=
list:Ignore">&middot;<span style=3D"font:7.0pt &quot;Times New Roman&quot;"=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Total packages in CIP Security image - 242<o=
:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l1 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol"><span style=3D"mso-=
list:Ignore">&middot;<span style=3D"font:7.0pt &quot;Times New Roman&quot;"=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Custom CIP packages (from isar-cip-core reci=
pes) &#8211; 13<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-.25in=
;mso-list:l1 level2 lfo3">
<![if !supportLists]><span style=3D"font-family:&quot;Courier New&quot;"><s=
pan style=3D"mso-list:Ignore">o<span style=3D"font:7.0pt &quot;Times New Ro=
man&quot;">&nbsp;&nbsp;
</span></span></span><![endif]>These packages are created by recipes in isa=
r-cip-core or isar that are deployed into image as a .deb file.<o:p></o:p><=
/p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l1 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol"><span style=3D"mso-=
list:Ignore">&middot;<span style=3D"font:7.0pt &quot;Times New Roman&quot;"=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Packages with Debian CI autopkgtest - 140 <o=
:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-.25in=
;mso-list:l1 level2 lfo3">
<![if !supportLists]><span style=3D"font-family:&quot;Courier New&quot;"><s=
pan style=3D"mso-list:Ignore">o<span style=3D"font:7.0pt &quot;Times New Ro=
man&quot;">&nbsp;&nbsp;
</span></span></span><![endif]>97 packages with functional tests, 41 packag=
es with non-functional tests, 2 packages with no tests running in debian CI=
<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l1 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol"><span style=3D"mso-=
list:Ignore">&middot;<span style=3D"font:7.0pt &quot;Times New Roman&quot;"=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Packages without tests in Debian CI &#8211; =
89<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.5in;text-indent:-.25in=
;mso-list:l1 level2 lfo3">
<![if !supportLists]><span style=3D"font-family:&quot;Courier New&quot;"><s=
pan style=3D"mso-list:Ignore">o<span style=3D"font:7.0pt &quot;Times New Ro=
man&quot;">&nbsp;&nbsp;
</span></span></span><![endif]>70 packages have tests available either in d=
ebian salsa or upstream.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:1.0in;text-indent:-.25in=
;mso-list:l1 level1 lfo3">
<![if !supportLists]><span style=3D"font-family:Symbol"><span style=3D"mso-=
list:Ignore">&middot;<span style=3D"font:7.0pt &quot;Times New Roman&quot;"=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Packages without tests in upstream as well &=
#8211; 19<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">There are a few packages =
that do not have tests defined in either debian salsa or upstream. I am lis=
ting the packages that do not have tests defined in either debian salsa or =
upstream below:<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"1261" style=3D"width:946.0pt;margin-left:35.85pt;border-col=
lapse:collapse">
<tbody>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid black 1.0pt;border-bottom:none;background:#8EAADB;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Binary Package name<o:p></o:p></sp=
an></b></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Source package name<o:p></o:p></sp=
an></b></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Are there Debian CI results ?<o:p>=
</o:p></span></b></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Are upstream tests available<o:p><=
/o:p></span></b></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:solid black 1.0pt;border-left:none;border-bottom:none;border-right:s=
olid black 1.0pt;background:#8EAADB;padding:0in 5.4pt 0in 5.4pt;height:15.0=
pt">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none">Remarks<o:p></o:p></span></b></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;heig=
ht:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-files<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-files<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er:solid windowtext 1.0pt;border-left:none;background:white;padding:0in 5.4=
pt 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-passwd<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">base-passwd<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">hostname<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">hostname<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libmnl0<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libmnl<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libnsl2<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libnsl<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpam-passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpam-pkcs11<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">pam-pkcs11<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpasswdqc1<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">passwdqc<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libpython3-stdlib<o:p></o:p></span></=
p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">libreadline8<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">librtmp1<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">rtmpdump<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">linux-base<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">linux-base<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">media-types<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">media-types<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:45.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">net-tools<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">net-tools<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:45.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" valign=3D"bottom" style=3D"width:419.0pt;border-top:none;=
border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid wi=
ndowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;height:45.0pt">
<p class=3D"MsoNormal"><u><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black;mso-ligatures:none"><a href=3D"https://git.launchpad.n=
et/ubuntu/+source/net-tools/tree/debian/tests"><span style=3D"color:black">=
Few functional tests in ubuntu: https://git.launchpad.net/ubuntu/+source/ne=
t-tools/tree/debian/tests</span><span style=3D"color:black;text-decoration:=
none"><br>
Autopkgtest running in Ubuntu CI </span><span style=3D"color:black">https:/=
/autopkgtest.ubuntu.com/packages/net-tools</span></a><o:p></o:p></span></u>=
</p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-minimal<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">python3-defaults<o:p></o:p></span></p=
>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline-common<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">readline<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">sysvinit-utils<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">sysvinit<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
<tr style=3D"height:15.0pt">
<td width=3D"155" nowrap=3D"" valign=3D"bottom" style=3D"width:116.0pt;bord=
er:solid windowtext 1.0pt;border-top:none;background:white;padding:0in 5.4p=
t 0in 5.4pt;height:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">tpm-udev<o:p></o:p></span></p>
</td>
<td width=3D"171" nowrap=3D"" valign=3D"bottom" style=3D"width:128.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">tpm-udev<o:p></o:p></span></p>
</td>
<td width=3D"191" nowrap=3D"" valign=3D"bottom" style=3D"width:143.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"187" nowrap=3D"" valign=3D"bottom" style=3D"width:140.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">NO<o:p></o:p></span></p>
</td>
<td width=3D"559" nowrap=3D"" valign=3D"bottom" style=3D"width:419.0pt;bord=
er-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-ri=
ght:solid windowtext 1.0pt;background:white;padding:0in 5.4pt 0in 5.4pt;hei=
ght:15.0pt">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black;mso-ligatures:none">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><br>
As suggested by you in the previous TSC meeting, we are looking for any tes=
ts available for the above packages in other distributions as well. So far,=
 we have checked ubuntu, where we found a test suite for the net-tools pack=
age. The rest of the packages do
 not have tests defined in ubuntu as well.<br>
<br>
We would like to understand your opinion on the next steps to take or other=
 distributions to target for tests for the above listed packages.<o:p></o:p=
></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">Thanks and Regards,<br>
Adithya Balakumar<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_TYCPR01MB96695706DE27A0CADA000C27C4FE2TYCPR01MB9669jpnp_--


