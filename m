Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3222DEB64DD
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 04:20:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.7278.1691036403683677686
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 21:20:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3734K1Dv1398031; Thu, 3 Aug 2023 13:20:01 +0900
X-Iguazu-Qid: 2yAbYAYqEE8CKq94Ur
X-Iguazu-QSIG: v=2; s=0; t=1691036401; q=2yAbYAYqEE8CKq94Ur; m=lYzbgtJga95xpVHRI1wsIG22wCeECScwbQTwWfixvOc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 3734K0HE1882807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 3 Aug 2023 13:20:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4HAlrlK7ErGwFklHddzxkVDIt8WWdBbTdc58C00o592FBtFmb+oXMblpRqFzpL7/hToRpMLKGiOejjOkOI73oiVMqvRZbVDwekh6l9RZz9g71WZnNNDZd5fCR/erqr0dyA9vYTiSYEMb5kWCBxsEVzfjIcbQr9AUcdbCsEFyjlJazUIAtBgSe84WEkgIwzda4KF/HwEXNcdseVbh4iHXtxBbaShzycs+OJbPYuZ2eHneFJhxjrNT6lDAYlv2/cZ0E0Z+F9/Q8DHhkoUtNxBqRnp78gY+MxFxkN0Ilh1UxmRJ1cajTO/KBw9fxxzoz3Ym2f7ygSRTMUBdathbskiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn4x6R2uU038rTRj74Hyy1BJv/bVKPqUDNIrjYtwzdY=;
 b=HOPz+MGPJhylOLELXVcLkQOLKsnUivYUMfsrQqMTl7ynBgRDvCcXBv+ffNrmeRK8zkVnBrz3j2/bi0zdEZjGfXfMKAHXmO10EIDfasbSjNMt1PQgTUIUZj+M83hFGROeX/TnZqHn0OHuQ6yMZ4Vp+SvY1/FecheUZPAj2zrFOg8AzDRf0mXW0ClicteF9aY4Y4G1PQKDJUdQDlJc5iTPrPYfXmuvI4z9aD58TvvCfvr5K36dTkcSo2jKFhV+rYv/l1L/RvKe1E35OvXay0ma5ReLh87ZdDOV3hdFEdsrUxdELaQOCze7IH8hYSPGOikKtlDRjkJ7ThEJrygh+ofL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core] security.yml: Add additional features to security
 image
Thread-Topic: [isar-cip-core] security.yml: Add additional features to
 security image
Thread-Index: AQHZtLR2Pw2+Dja+gEy+l748u8HBXq+39oMAgADTxgCAH04EUA==
Date: Thu, 3 Aug 2023 04:19:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB494502FCB30FAE2544D7E5FBC208A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20230712113153.1194397-1-Sai.Sathujoda@toshiba-tsip.com>
 <5b400f7b-4039-2fc8-5f84-2fe647ff8a3d@siemens.com>
 <fd3970a0-2375-6838-2d7d-182c6d392826@siemens.com>
In-Reply-To: <fd3970a0-2375-6838-2d7d-182c6d392826@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|OSZPR01MB9548:EE_
x-ms-office365-filtering-correlation-id: e4b12327-e00e-40a8-fde4-08db93d8e5c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WjDdNACSbcw+89oqRPzxI6VUpAoSGev4U7aHD52PkKRzYiS81rqFN9btm2t2qgrTHFVNjCcFgfGIrGTrKtV9Y4TgGOQ2qVw/D5YfTSxT4hI6u/EXk1K4ilAecTvtlFp3SDPdVz305iYsuBBr9Bh5Xi52uDAfDnV1PWaQKj1CHZ7+X4Zh+NVNQJLIE/5oGCaAaeB2/+yNvw3PymssM4B0PIuHkWn2wlZ63I2CrrCa+gcHngQMHQu0EJ0RgxE+0LLY7q/Ld84Worh5MBq1UcVXGgu4sKveLRSUj5crWNzatwKhYIVd+nkQ8ylgYJOnilYnlAu2LzjrvDmGscCtqXtZBSeAjDLtv+l8R2DlT5PFZp8vJa6hoNo3yXog8ufXnGD/YmGEWbeSffig6nce+GAmDhsNlKzu9UbTzHAqzAQhQQ2oV0khL1O2zCcm/7oflwRbg2LlmCldxxuTaLMbMPsu9pfPs3pfJn0GxJKaWDuHATi3gN54zJuW0pBuhp/DOmKnYO/YGNz2wyR4v7xoBvgAf8zs/u11mNSDron4TJybOSqDbbp8CauWrlSw6sOzVqlvIZLK14YBeQU9ylqDPcXcDKl7MKqOJChItuscrOrDe3U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(53546011)(26005)(186003)(83380400001)(107886003)(15650500001)(316002)(2906002)(76116006)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(8676002)(8936002)(41300700001)(71200400001)(7696005)(52536014)(966005)(9686003)(54906003)(478600001)(110136005)(55016003)(38100700002)(122000001)(6506007)(33656002)(86362001)(85182001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dkMzMC9Sd0U3QlNSdWQ0QUtncnp1dUIxVW1XSkZ1MnZ5VkFRWEQvUnhubzBh?=
 =?utf-8?B?QWRPODZ6TTJMbHlCT3VKQkNUMVBCTVB2QnhXNHhnRllGQWk1cndiU2dyTUhO?=
 =?utf-8?B?akdIVGxzMXBvQUtNWVFESEZLUk0vVGNXWmRUYzVhVEp2NlNRd0FOb1VHaTNr?=
 =?utf-8?B?N2FWOFptNVNZSW9uTCtWRzF6eUlKTlo4NDFiOGhDMGxuUjNNdzNNSDU5OEdJ?=
 =?utf-8?B?SWVjSUU4UGhoWHdhbm9zYWErNytJZ0ZEQklDWk5pSStkaERyTlRDNTFYYS80?=
 =?utf-8?B?ZlhSUzVRejVONktOVDJxYTFxVVNSWmVMUEZrZzVXT2gySkNObG93Q1FGS0M0?=
 =?utf-8?B?WWJ1OHdDdGdLVXZVOHhNQWQrcXdubFdpTnNvckFMcHl0RHlScDUxWUlxa0JG?=
 =?utf-8?B?d1VJK0I0WGpnYnpMWmRFNGhLMnZxdWNRTkNTWS9FRWJYeFZxRHdJS0djYURL?=
 =?utf-8?B?bktkYXQ0WlBuMFZmeGYxVE1SbnkzRm1jOE5ncGtiZ055Mkp3aEpVOVVzR1VS?=
 =?utf-8?B?TlljNno2SmFIcGVTZHJ5cEZObDRXWFlVYjNPdE5rWmlaSTFHSE1peUdiZDg4?=
 =?utf-8?B?ck5JYkRtUDM2Y1poaGIwdjR0NXoxdmRpdndEZnpCYTByWVFYZnNrQ3lLd05C?=
 =?utf-8?B?Nm84R2Q5ak1Oa0N3Y1dQSlFIZHltK1hhbkVNSWt1TStkSlB3MG1qOEUzZk5j?=
 =?utf-8?B?dVFMTmJXQ0ZWQUYxNWYvNmV1RW5XZHA3NEtLV2J6clJGMjlTcFI4bEMrSkRr?=
 =?utf-8?B?eHVWS0NPTDNQZ1pZL3VjTEhYcWRtbEYxdUFZWWYrd0tOMkV6OXlGYk9CZ0lh?=
 =?utf-8?B?WTVQWDRqNkFUakhhUENzZTZrdDdnMGpteWhJRng5di9YeWhLanlSZkFlem8z?=
 =?utf-8?B?N2w2UmY0ZEY3L0dMMC91QW1CZGl5UEdIT0dGclNLYUFxOFRQWFJZNEdaY2pC?=
 =?utf-8?B?UWsraFJDaDZ5ZFFXR2ZEdHhveTRSYU1GQldhZzB2UUZyYU04enc1Y0E1ZmQ3?=
 =?utf-8?B?M29KbCtXRVJIVWljcmRuU0p1MTdkUEFabFFvU3dMWmU2ZHdrenFVeElpbG5u?=
 =?utf-8?B?aUtnNDlnaldZalVDV2t4Rmd1bm4zay9YbU5uV042eHpaQ0VJMlVObncyWndm?=
 =?utf-8?B?R1FlUTViVXpwaTRVRmlRdzFudzZNa0p1TWNlb1VYZE9LaDJDc3RCVGlUQVBV?=
 =?utf-8?B?dHMzeC9mMkFJL052SVFVaWVLWDJlWHUwcmlXeUhXMG9GMVR3Z25mOWl2U05C?=
 =?utf-8?B?ZWR2akl4Vzc1cDdkdFF2dXZ5SkZFK010cVYxZldIQ2tjOXZLLzNieTVaNkJN?=
 =?utf-8?B?L1FXazRHRHhLcWdYLzVjYWJyOXBTNU9jR2NiSmhlZnFNYjBjQWV2WlVGMDNH?=
 =?utf-8?B?am1NZ1JDQ3R2eG5tbmJxSEx4cFd1RzNiN2pFV2dkMzE4QzdFRSt4ODJ2WVBF?=
 =?utf-8?B?OWtIMHc2b0R2MTcxNHprd284Y01wMUNDTlhYY2RrYnlPVXhFbnR4bTJuMjNG?=
 =?utf-8?B?VTRTcmFmdzgvUVdZOUp3d3pvVy9ma0dLeTJ0dGpsUUJqdkJTcVcrc0VzSjBq?=
 =?utf-8?B?WmcvSWRjR1draGFEOFRjc1Z2Y0MzVUtrUmJ1OFFaUE5pdlBnWkV1NXFVbGZk?=
 =?utf-8?B?RytrWVc3cFNiM1duTGU4RnFwZ2haOGRrbWgyb0tEVEhWRk9QVnJYU2dxQXU1?=
 =?utf-8?B?dHkyUnkxNFVqWk1qOXFsUE9VRVpOdkt1SzFOcmNSVkFUeEpBdlFBNGdrRU5G?=
 =?utf-8?B?UUIzalpwYUdYY2JpM2dwaXpyL0FVbnNkQ3RzdW1aQ3RVT3dWbmhyVHp6Lzl1?=
 =?utf-8?B?RXV6Z1dIT0pER3JGekExOExEVkRPQ2Z5OHhjR1VjQWJUMm5hdnV1WEczNUVJ?=
 =?utf-8?B?YnpKZG96MkxpbWJRVGlnNHlFa1pPNG1RTVBvNVBNeGt6NC8rUVhrVXpYQmM0?=
 =?utf-8?B?VCtWQTNmUFpDTFYzeGlKQWZBaGJhcDNWNlVFUGluN1BMRmxLWG8vQnVNeEcr?=
 =?utf-8?B?SnJLSUZSL3ArN2RjcjFXWEk4emViNGxZR2Njdmorc0dZZVFtcVpuemtLbStv?=
 =?utf-8?B?VWxDcjExa0lxY3QyQ09SMzFqcHFCbU0yMGNKUDNNOVgrYXQ5OFMyTUlGd1VN?=
 =?utf-8?B?d3hkU1hRWVJ4aFBSV0J1MXB6dHNMMG01MjhGeTZ3dEI5Ujk5d3Q1cmpaZk52?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BSw9jMcJrRyEI2vBvCVsQPh4JTEHuRvg1Zn0vd9v7ru/MhOuCQalIIAVOcH/5/lOgNVDrAWajZtOpRm5+nodgLQ94eMyac/VIxrC8O0xaLSnUT39m2oGokTiv0SMqEm4ufjqgSmOOZj1U6MKDVM5pa4w/EV9/IQyCTTeJ1/i6pHHRWFih1vT1KUUgUTnj3TZiShRAegfWhqSme/WZ2wykvTlh8cS4L/kJfylDCKf1XVPl/0VELCQSDYRVc0Pfg0T39rjzRdiNYUogjkCLN+TvkK5UROMyM2oMC2j+wh+k/F9ExV6ni2Puj0D1t6wo68FE9nJ9y74C3ovGhOIi/YEjfC8zQ982DLI6t6yTAn4E/sAQ4HwXm0JoV/9jD8Sjr6rm94iSFEQJbpUUJenyiO2BInTZfGn6v8R8muTrlojRBRKZ5o02kM2+ydyZGKc28UKkPCHMKvMLT97t9CAheWiOMlfIFOQoU4pi+Zq0IvGaoM8TdgsLBnLXKyXpA/36lla25RXE2YBBdJz8oplUee/MxW5ga/RQfA8OxKAhdDgdjQHyCGs+HZE4r77YjyPx91rzAQIPSoH8O03NDLObA6f7P0xmuW20efxgfaiCLM2hjSEI9NRIEKxuvh1mqdV8BqgZMYIOQWf+g/jb11HiOa/u17pO/LfBe2/I7Nvu7b2lgrnZy71sPnri2OK8HFpF8xKlGdO20jLj6BeWvpG1D5g587iU1S0LE9ejlVNPtaQDHJ8oUsoDUU0xJDuxbAGUSv12VMlGVoFklvCJI8z6T3mWKlBi5gy/hgKGaJxUdFHK0YmdUo8EyIIt/nKM+6KzbuOEi25V9Hf7V/dJc6lDHOz+g==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b12327-e00e-40a8-fde4-08db93d8e5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 04:19:57.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMbngs46gJFfJi+LLeCiMZyC8qAwFr6vguFJuh0zp0OzxGUXJ0U3VuHlAxPJSgbCfLXfiSk+RzZX80sBVNlPdtjIejQevhzyEb8AbONtvxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9548
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 04:20:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12541

SGkgSmFuLA0KDQpTaW5jZSB0aGUgYXJ0aWZhY3QgdXBsb2FkIGlzIGZhaWxpbmcgaW4gQ0kgd2l0
aCBpbml0cmQgaW1hZ2UgbmFtZSBtaXNtYXRjaCBpZiB3ZSBpbmNsdWRlIHRoZSBhZGRpdGlvbmFs
IGZlYXR1cmUgcmVsYXRlZCAueW1sIGZpbGVzIGluIHNlY3VyaXR5LnltbCwgY2FuIHdlIGNvbnNp
ZGVyIHN3aXRjaGluZyBiYWNrIHRvIHRoaXMgcGF0Y2ggaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVj
dC5vcmcvZy9jaXAtZGV2L21lc3NhZ2UvMTIzMDQgb3IgZG8geW91IGV4cGVjdCBhbnkgb3RoZXIg
Y2hhbmdlcyA/DQoNClRoYW5rcyBhbmQgcmVnYXJkcywNClNhaSBBc2hyaXRoDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMu
Y29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAxNCwgMjAyMyAxMTo0MCBBTQ0KVG86IGFzaHJpdGgg
c2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT47IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpDYzogZGluZXNoIGt1bWFyKO+8tO+8s++8qe+8sCBU
TUlFQyBPREcgUG9ydGluZykgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tPjsgaGF5YXNo
aSBrYXp1aGlybyjmnpcg5ZKM5a6PIO+8pO+8re+8pSDil4vvvKTvvKnvvKfilqHvvK3vvLDvvLPi
l4vvvK3vvLDvvJQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpwPg0KU3ViamVjdDog
UmU6IFtpc2FyLWNpcC1jb3JlXSBzZWN1cml0eS55bWw6IEFkZCBhZGRpdGlvbmFsIGZlYXR1cmVz
IHRvIHNlY3VyaXR5IGltYWdlDQoNCk9uIDEzLjA3LjIzIDE5OjMyLCBKYW4gS2lzemthIHdyb3Rl
Og0KPiBPbiAxMi4wNy4yMyAxMzozMSwgU2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tIHdy
b3RlOg0KPj4gRnJvbTogU2FpIDxTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+DQo+Pg0K
Pj4gRnJvbSBJRUMgY2VydGlmaWNhdGlvbiBwZXJzcGVjdGl2ZSwgYSBzZWN1cml0eSBpbWFnZSBp
cyBuZWVkZWQgd2hpY2ggaGFzIHRoZSBiZWxvdyBmZWF0dXJlcyBhbG9uZyB3aXRoIHNlY3VyaXR5
IGN1c3RvbWl6YXRpb25zLg0KPj4gMS4gRGF0YSBlbmNyeXB0aW9uIChDUjQuMSkNCj4+IDIuIFNl
Y3VyZSBib290IChFRFIgMy4xNCkNCj4+IDMuIFNXdXBkYXRlIChORFIgMy4xMCkNCj4+DQo+PiBU
aGUgY29uZmlnLnlhbWwgd2lsbCBub3QgaGF2ZSB0aGUgZXh0cmEgZW5hYmxlZCBmZWF0dXJlcyBh
cyB0cnVlLiANCj4+IEhlbmNlIHRoZXkgc2hvdWxkIGJlIHBhc3NlZCBpbiB0aGUgaW1hZ2UgcnVu
IGNvbW1hbmQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2FpIDxTYWkuU2F0aHVqb2RhQHRvc2hp
YmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+ICBkb2MvUkVBRE1FLnNlY3VyaXR5LXRlc3RpbmcubWQg
fCAyICstDQo+PiAga2FzL29wdC9zZWN1cml0eS55bWwgICAgICAgICAgIHwgMyArKysNCj4+ICAy
IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kb2MvUkVBRE1FLnNlY3VyaXR5LXRlc3RpbmcubWQgDQo+PiBiL2RvYy9SRUFE
TUUuc2VjdXJpdHktdGVzdGluZy5tZCBpbmRleCBjOTU0MGJlLi45NzAwMGRhIDEwMDY0NA0KPj4g
LS0tIGEvZG9jL1JFQURNRS5zZWN1cml0eS10ZXN0aW5nLm1kDQo+PiArKysgYi9kb2MvUkVBRE1F
LnNlY3VyaXR5LXRlc3RpbmcubWQNCj4+IEBAIC0zMyw3ICszMyw3IEBAIFNhdmUgJiBCdWlsZA0K
Pj4gIGBgYA0KPj4gICMgQm9vdCB0aGUgTGludXggaW1hZ2UNCj4+ICBgYGANCj4+IC1ob3N0JCAu
L3N0YXJ0LXFlbXUuc2ggeDg2DQo+PiAraG9zdCQgU0VDVVJFX0JPT1Q9InRydWUiIFRQTTJfRU5D
UllQVElPTj0idHJ1ZSIgLi9zdGFydC1xZW11LnNoIHg4Ng0KPj4gIGBgYA0KPj4gIA0KPj4gICMg
Q29weSBzZWN1cml0eSB0ZXN0cyBpbiB0byB0aGUgTGludXggaW1hZ2UgZGlmZiAtLWdpdCANCj4+
IGEva2FzL29wdC9zZWN1cml0eS55bWwgYi9rYXMvb3B0L3NlY3VyaXR5LnltbCBpbmRleCAxZjM3
NDViLi5iMjFmMzMwIA0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9rYXMvb3B0L3NlY3VyaXR5LnltbA0K
Pj4gKysrIGIva2FzL29wdC9zZWN1cml0eS55bWwNCj4+IEBAIC0xMCw2ICsxMCw5IEBADQo+PiAg
Iw0KPj4gIGhlYWRlcjoNCj4+ICAgIHZlcnNpb246IDEyDQo+PiArICBpbmNsdWRlczoNCj4+ICsg
ICAgLSBrYXMvb3B0L2VuY3J5cHQtcGFydGl0aW9ucy55bWwNCj4+ICsgICAgLSBrYXMvb3B0L2Vi
Zy1zZWN1cmUtYm9vdC1zbmFrZW9pbC55bWwNCj4+ICANCj4+ICB0YXJnZXQ6IGNpcC1jb3JlLWlt
YWdlLXNlY3VyaXR5DQo+PiAgDQo+IA0KPiBUaGFua3MsIHN0aWxsIGFwcGxpZWQgZm9yIHRoZSBy
ZWxlYXNlLg0KPiANCg0KQXJ0aWZhY3QgdXBsb2FkIHdhcyBicm9rZW4gYnkgdGhpcy4gQW5kIHRo
ZSBzaG91bGQgc3RpbGwgYWRqdXN0IEtjb25maWcgdG8gcmVmbGVjdCB0aGUgaW1wbGljaXQgc2Vs
ZWN0aW9uIG9mIHNlY3VyaXR5LnltbC4NCg0KSSdtIGRyb3BwaW5nIHRoaXMgZm9yIG5vdywgaXQn
cyBtb3JlIGNvbXBsaWNhdGVkLCBsaWtlbHkgdG9vIG11Y2ggZm9yIHRoaXMgcmVsZWFzZS4NCg0K
SmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQpDb21wZXRlbmNlIENlbnRlciBFbWJl
ZGRlZCBMaW51eA0K


