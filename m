Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A517ECF318C
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 01:41:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.98620.1727833288010737469
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Oct 2024 18:41:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=GYWf3kXl;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1727833279;x=1729042879;bh=rlmGqNc3P0eu+TcvFpub2C02xM6TOIkvHPlkpFV
	ir90=;b=GYWf3kXlkt8SCTVwetQVJdwLIFCYZbN5aW8vRx7+jRwZAOsIyhedg5SaELLjPG2amAlSS
	JqDEmLY3OKcfCdhyaXZq+riv62NGG4o7mavCbsrAbNGudcaBWDRE5huC7r1S+7mym1DjCMYYlKuzr
	Be+7t8z3x+A38YMt0DIsfwv22OoDkotn4S2AxvOZl1D+h63KBGjSd8b76Nvkww9PHzc7ZGj70pni8
	AxLri5/+Q2iRTLUXL90vlJPFLo1HM5vnnNFuCNLyl9Y8nQsFl78hXtKFc51A90w07GxxHN+WomnNs
	jd2Y2AgEpbmuNr+wYKLCwDwJp4UGM1VKdTi5bQLw5Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4921fHlu1271779; Wed, 2 Oct 2024 10:41:18 +0900
X-Iguazu-Qid: 2yAaPcpxokhaZlS96x
X-Iguazu-QSIG: v=2; s=0; t=1727833277; q=2yAaPcpxokhaZlS96x; m=3BqHnynsmol2ZemWuyzTO7VYI4RwEUnv+1PrpahzkbI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4921fGwF1101540
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 2 Oct 2024 10:41:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/fDz2LBVNqvcQ90OOcFUvF5nBnOAtOVeEKHuNBkc7Qs6aFm3I+FGEXXFGBWGZ7VnqSH0efoUjItN0VZM+rJMs4pdpuvZi5GYb7mvBrorGFg5YTa+nVUcrLUD2s8v8Ue5+B6Qa/fuerjwe+LhVoIh+84iCi99LVUmIxjLLOpQPFdbM3Fc5KIBB0pZIMe7GWS/bPmN9C7Wh3VEDdo7bOdfGZXd9DObn+NkL+mMLwIomOmtcPzZ3Xou1N0vBqeXgxwvTbuz5jnA1vtA6gznTatl2z096cC//LciCxOhTSNKwiHS0XHwL54kupDO6ucE1jE7qV0d1lh7OsT75Cn49X5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zodEZelA2R3rcsZ/R9LUyHY8O0pCPA7MKaTU7H4ITbc=;
 b=Oczpfw1a9CZ/pwhAHhvynSWrZIA5tQTJDiSx3z6omGSpPirX0mGgHsKBH2QcoKq4OTm63dHZSHNYxQBM1jYj8eaWIMskedu6yWJFbycgCzQGZQPsWCZzn17xbZyNWEawAN6WnFENtG3nHvXxmi7KwYYay+xZTY7xVBlwUDDFXm6Eg8UH/tZ97u3Nh866hqbugzlXpWN3M0o0voKsVnuLTQmIzsYMZ02F+zz/BBDVEGqKsE35I3xWPu7gc+6UPY0Tax+pFGuL4GWeG3KhinDZWMGuGdeGRcfKZyy+xOJV0oJaZR2ouJUIGnVGSjINI8puYQeneDXQFS5ypcwEPWX/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: [cip-dev] 6.1.107-cip release
Thread-Topic: [cip-dev] 6.1.107-cip release
Thread-Index: AQHbAC8HGLdMoGolZEifqGcS0srzXbJLSTFAgB5HCwCABpF3cIACtZig
Date: Wed, 2 Oct 2024 01:41:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388682D56B1258DD225BDC792702@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZtqwJfVY1s49vSdo@duo.ucw.cz>
 <OS0PR01MB6388BD6095E8058C2675DC39929E2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <OS3PR01MB642161E95C3634866218A284D76A2@OS3PR01MB6421.jpnprd01.prod.outlook.com>
 <OS3PR01MB6391DC2B457500DBB286A07B92762@OS3PR01MB6391.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6391DC2B457500DBB286A07B92762@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TY3PR01MB9731:EE_
x-ms-office365-filtering-correlation-id: 5e30a97b-71e1-4b65-db8b-08dce2834d4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NlRUOFF3Z2hqRHJ3ZnVYY3pPMnRMVjROaTRhb09SZ3B3QnQyUlVxN0ZP?=
 =?iso-2022-jp?B?bkV6MGxxVlNUVE1CTjl2SFlNcGV1NnpFK0I0S04vdEo3akNxN21kc05x?=
 =?iso-2022-jp?B?QWpJQUFYZkJaazR5clM0dmZaK2MzbHpzTXBlcmtHKzFRcnl6Nk9iNW9k?=
 =?iso-2022-jp?B?dHQwRjVKZ0lVc2NOVWJXVHZYM0QvSURSQ01GNzltc0Y2dHJVYXgvdjJJ?=
 =?iso-2022-jp?B?dTFSWkJMV2xGc1ZJbXBCY2IzRkFGd0ZwVGs3Z1FwekFWQ2tUclJXaWpI?=
 =?iso-2022-jp?B?azI0cytveXVBQjQ3UTFwRDRYTDBITnAzdVV2Y3lyako2SFhybEdFT0dC?=
 =?iso-2022-jp?B?UHZYMExvbEZGS1d0b3ZzbGJKMnFHTVlUMXJGUU5vREsyR2NBNVNWaDVR?=
 =?iso-2022-jp?B?YlpkZ0ZBS25hZnQ3MDdjVGtkNEpsMmdTUDY3QWVrQXBVcFhVNWQrTzJK?=
 =?iso-2022-jp?B?UmFCZEpZeTJ4Vy9PdGxBdTl5RDROalBqc09McUlOajdDS0RFaG9TbDM2?=
 =?iso-2022-jp?B?UmpQU0hQL1E3eWZMOG1zcitreVJTVVZzL1A3VG03T3FST1JoMnBNaThO?=
 =?iso-2022-jp?B?TS9hczBSbzQ1WC93d3hESzM4anpReU9qY3NZL0ljOHI3NEk0bHpEN2Y0?=
 =?iso-2022-jp?B?YUV3ckkrdStiQjNzcjhyWnVpMWVMK20zd1ZiSFR2SU55a21VQlliWWJw?=
 =?iso-2022-jp?B?RkNaU1RhRUI4R0szakZEQmNXcm04WEYzMytrQXY2aklXMmp6VUMrR0Fw?=
 =?iso-2022-jp?B?aFh6RHBWVG4rZWdVaEc0T3p0aHoyeHhEZ2k1YVM2T1IzU0RIYzFRV2s0?=
 =?iso-2022-jp?B?RkI1aGtiTVd6dmpsenlVQyttTWg3SmJ4bUJtM081TDdyL0R1ZFYyZGJC?=
 =?iso-2022-jp?B?KzR5VUg4bjZIUC9YNlFwWit6M0dqdWVhV0FDbExrTDV3Zi9TNEpNRzFh?=
 =?iso-2022-jp?B?K0JGbFRlLzFabjFtcGZMWTRYbmJNcWpmd1NvdzRIdGVWRC83Q0JHSTBy?=
 =?iso-2022-jp?B?eG5Ia3R3ZVc0WUp0cXJOOExtZm9iUVVKSWc3WFpDTmpBUS9wUVlIL0pm?=
 =?iso-2022-jp?B?eW45WXJlOEg2aDF3MHVDZkNUUGVyVGRZNm5sYVRrbjhTSnVTOGMybDJS?=
 =?iso-2022-jp?B?OHh3Zll3Z0c2dE4wR3RFNklianRNWjJzR1JXRzJpWForcU9RNUlPWXVv?=
 =?iso-2022-jp?B?RlBkdmR2aHk5ZmNxK0ZjK3ZnRmFUeVp3bStZUUlyZFN1WEo1ZVd1aWIw?=
 =?iso-2022-jp?B?RUptL2Z5T3kwYWZWa0FHajRZOERDdHZEQ3hoMGRWR05uZVBRWXdqRlJo?=
 =?iso-2022-jp?B?SkN3Z25ZMG1IRXlnMEFEQUt3RzZXZFFjOFI3cURaTWRKOURtVXkveDhZ?=
 =?iso-2022-jp?B?Q3pPbHlpYmtSOG1kWldhbXNJc213L0Q4Ky9idjl2TVpzRHBXYjhoOGdv?=
 =?iso-2022-jp?B?WENmY2RsdUhhRXZzRUswaXNTTmZWN0NHYm5MdjZoT1hsTVNXOVl4NGZU?=
 =?iso-2022-jp?B?aUt2OVM4TkRhOXZPMWVVVVU3WThqQmcraSs3TkZ3TGpVYjVLYzM4aW43?=
 =?iso-2022-jp?B?b3h1MjhZV1o1ZGlsTU53eFU4bWl1S0l5SzJHcjdrWlZVNUplb3VjYlBv?=
 =?iso-2022-jp?B?Q2p2a1JneUQrWVVUSGUzdEZ0RGNwWEw1RUszUWFydnphbzhjOGtaOGQ3?=
 =?iso-2022-jp?B?ZmpRbzBWcWpaZXYyMEFja290QUxJRGx1RjNYWHRnTFMrYkF4eWtKaVJD?=
 =?iso-2022-jp?B?Vi95dnZhUDlXR1lnZUlyQWlUOVlEbHBtcUxnK3hZTnpIRjFyd0RIb2Zu?=
 =?iso-2022-jp?B?ZmQ5c2VUVmJTa2RvTzBhZi93NlFjZUtRUksrRGJRdU5LSHpFd0VaM2F3?=
 =?iso-2022-jp?B?bG52a09ybWNudHZ2eGtFQndGK3UwWVlHakVBUyt6c1c3MFh4VEpEYjZ5?=
 =?iso-2022-jp?B?TUUzejlWQlQwckZYMEFFcHZIL1IybGQ3WnR4bjdkMmNURVVlbytKMU43?=
 =?iso-2022-jp?B?Mis3dVRDRWtwSzN3c3pmbUpKTzZuYQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UDVlcU0zdExZRThYaWRjOHlNY204ajNvZG5YMWx1MTFhOVVXcUZLODVr?=
 =?iso-2022-jp?B?M1F3MFd3aGo5V3R2QmhYR0FnQUFpZWlzZk02QUdtNGZseFZGaFNKU2Zm?=
 =?iso-2022-jp?B?OEdkYXdZZjBTMnBqRjE0cTBOZzV2SjJGU1ZkS3N2ZVRlZUVZbTd4Q3c3?=
 =?iso-2022-jp?B?WUlBUklTa1A5emJpUnhxa3pJSDkxTU9jTkxzSHhESmlVaEN3YWFRUGVQ?=
 =?iso-2022-jp?B?V3BmSE14cFkrdjlFMWFFSjJKTkNWUERBSmRGeDFIcGpZU2NaRnMrRW94?=
 =?iso-2022-jp?B?T2dyYVZoU1BpYTJDRFVvbk0xQkIwUlJ3djlwanBpeTdzalNBMGNOYTNV?=
 =?iso-2022-jp?B?TldxLzAzdFBJdGtNOG82TmpWcmJDclllL1JXWXRIdklPZFdEVytSRGUy?=
 =?iso-2022-jp?B?SGhyUGRoakg3ZzNTaWxGUHMrV0NURjRHblZ5OXQ1dExQbEZvTGlURWxs?=
 =?iso-2022-jp?B?VnBHeUNMZGxFLytTNTZhUnBsRi8reDNKUHlFVVRPWUNwYnJabXZBNWY1?=
 =?iso-2022-jp?B?b1VMdXE2RUhNQXhvemgyVGkvTXYwQ1dWVUlqVTR2MTR3R0p1QXlWa1NR?=
 =?iso-2022-jp?B?bzMvbDgyTmNWTTZkNjdpbDRZQzZvdUlIbnEzMG5majQ1R3lCR1hRWFRn?=
 =?iso-2022-jp?B?YldCa3FvZERMbkVZeUNHTXYrSmdkWjdYL01LOFJaTjBGSWxyemNiVzRL?=
 =?iso-2022-jp?B?b1F6eSsxdFV5K3V3MEhPa2tjOERFUXZYbW15cVVON2Y2cndVQndyZytX?=
 =?iso-2022-jp?B?VnQzUlJ0NFVWT0thRUd3MG1yRFRrUC9VM2xOVFJSTjE4K01qNHRiS2RO?=
 =?iso-2022-jp?B?TXU3NzVJU3g4MkJmSDQ3UExHSEdrQnIwaGxRNEJRcDgzeDgxb1ZYbWlw?=
 =?iso-2022-jp?B?UGlSUVpCYnZZemdObU5PZnc3QmZ3V000R2xvT0xaUCtVUnQrMnNLWHA4?=
 =?iso-2022-jp?B?WWc4R0VXekVoemtXNU1MbEVpZGlhZG4zc1dJWkp0ZlcvZnczWGhFVU9R?=
 =?iso-2022-jp?B?aVFRcytvRmF1eEtnZ1hWNVcrakFYTmRyZTBQZzFNblQrbFppM2d6ZGxs?=
 =?iso-2022-jp?B?a3VGaVBZVTFkM3p2NjVLaTdyam5WbC93bEVyUVBJNXdPeEpUZ1pXY0h2?=
 =?iso-2022-jp?B?K0hUZ0tEZTdqNVNaRDQyUCt1ZXUyVHByYXdhbFJOTmxNM1dLdmIzK2Na?=
 =?iso-2022-jp?B?S1FhMW41OUxUa3BkaWFVOTBiTzJUWENtclRRUVZ0SmpTOGZWSTVEMFpU?=
 =?iso-2022-jp?B?eElsVG82cDBXZXBLd0VwQXpJZXJ6WklxVFVwN0dJM0lSWURPNkNIM2Vl?=
 =?iso-2022-jp?B?T2tDcU5WU3p3L1d1Z1lmanR6ZU80Z1ZUYVlNbnJzZis4Vm1UVjdkbTVH?=
 =?iso-2022-jp?B?amZnN0x5cFYvQjJiZmk0Z3VXSHRWd1hOU1JuS0RTT2xOU3ZrQnJldzdU?=
 =?iso-2022-jp?B?c0tlY0JZUFlVNjZGVzJEYWhGRVlJZ3AvbzU4MzhIZkszNXByYTBQRE4w?=
 =?iso-2022-jp?B?aXl5VW9LS05WK1BnbERVVmk0bEliOUlXSDFVMFNzK09GMVZGS0ZXbWVj?=
 =?iso-2022-jp?B?Vm42WStSL2VXU2Y5SlJFazhxaXZqT2U4T01TeEkybUlHcmZ1SkFhRU42?=
 =?iso-2022-jp?B?em9oM2JLdUthdWZGMUowb0VUckJxRXY2ZmhQUkUycThXM3ZZWmVkZ3Fh?=
 =?iso-2022-jp?B?WGx3WURMT0JuRHFPYjlyczhDNXlHRnF4SXBmSmVLandFK2Q2UFR1bE5V?=
 =?iso-2022-jp?B?aXlUM2k4WHdyS2U1dFhORkZtVDRDM0hOZk1zRkNoQzA4aGVvbitWRHNJ?=
 =?iso-2022-jp?B?aXdDOFQ5VFg3NnRTbS96MFZzOXR6VExsZHhIWEVpNXRqbnUrSmRSZE9N?=
 =?iso-2022-jp?B?R0Y5NTY0K2ZyK0N2WUx3OEhzeWVxbWVJY0w1Q0UwQ0FmNUxmTk9maVpJ?=
 =?iso-2022-jp?B?Njlxbmhld201WWJMa0lFWlo4cThISThBNXJtazk1L3NKdTcyNUNBVHA1?=
 =?iso-2022-jp?B?N2I5b1ZxMXBTamVnOVA3aS9IbjhRMFZVRHZHcUplMDFjaWFuZ0J2T1pI?=
 =?iso-2022-jp?B?bTRQSklLL3pxazgydmd6WmZaeWQzcFY1bFc2S1ZQemRyOEhOVFlPeHlK?=
 =?iso-2022-jp?B?WExwYTd4TWxRYjM1U1B4dVRROUkvS0J4aFVTOEs1SE1iZGxqdU9DbkJy?=
 =?iso-2022-jp?B?WGRKdHVXMmNrTm9MRUlmNjVGVG85cnR0V2d5c2t0VjVRTDAwekt4bmpJ?=
 =?iso-2022-jp?B?ek9aSCtsaUJaQnkrbGZNaFpjejJxQzhiYXVEUDBCOWpvSWFZaUdsdWtS?=
 =?iso-2022-jp?B?dVIwOERSUDhBS2dTbWlRVVRKek9URzJUVHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e30a97b-71e1-4b65-db8b-08dce2834d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 01:41:14.4676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QW/dq0YqXiaI2k9hHNaQ38k5UzYUgpooF+nOOENonAkdgxo0XHtGarndEv203sogRKIqwNbE6FkKc/0P8OYwnvXF4vKXxISOvst97tX1LlHbrOTVA8tRfWqfP8dS0bFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9731
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 01:41:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16947

Hi Koguchi-san,,

We updated kernel config and CI pipeline, restored the CI of BBB.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/7961623251

Best regards,
  Nobuhiro

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> Sent: Monday, September 30, 2024 5:24 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de
> Subject: RE: [cip-dev] 6.1.107-cip release
>=20
> Hi Koguchi-san,
>=20
> > I recently noticed that 6.1.y-cip has dropped the support or testing
> > on Beaglebone.
> > I'd like to know the reason and I hope CIP supports Beaglebone again sh=
ortly.
>=20
> 6.1. y-cip's BBB configuration would not boot, so CI was stopped by the T=
est
> team until they could figure out the cause.
> I am currently working on resolving this issue.
>=20
> https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blame/ma=
st
> er/trees/linux-6.1.y-cip.yml?ref_type=3Dheads#L217
>=20
> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Takuo Koguchi
> > Sent: Thursday, September 26, 2024 12:58 PM
> > To: cip-dev@lists.cip-project.org; pavel@denx.de
> > Subject: Re: [cip-dev] 6.1.107-cip release
> >
> > Hi Iwamatsu-san, and CIP folks,
> >
> > I recently noticed that 6.1.y-cip has dropped the support or testing
> > on Beaglebone.
> > I'd like to know the reason and I hope CIP supports Beaglebone again sh=
ortly.
> >
> > Best regards,
> >
> > Takuo Koguchi
> > Hitachi, Ltd.
> >
> > > -----Original Message-----
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > > On Behalf Of Nobuhiro Iwamatsu
> > > Sent: Saturday, September 7, 2024 6:49 AM
> > > To: pavel@denx.de; cip-dev@lists.cip-project.org
> > > Subject: [!]Re: [cip-dev] 6.1.107-cip release
> > >
> > > Hi Pavel,
> > >
> > > > v5.10.224-rt116-rc1 -- just wait for release, then do corresponding=
 -cip.
> > >
> > > v5.10.224-rt116 was released today.
> > > I will be releasing a -cip based on v5.10.224 for this.
> > >
> > > > v6.1.107-rt39 -- can I ask for corresponding -cip, or do the releas=
e
> myself?
> > >
> > > Thank you for your suggestion.
> > > I will worki on the 6.10.y-cip release at the same time as I work on
> > > the 5.10.y-cip release.
> > >
> > > Best regards,
> > >   Nobuhiro
> > >
> > > > -----Original Message-----
> > > > From: Pavel Machek <pavel@denx.de>
> > > > Sent: Friday, September 6, 2024 4:33 PM
> > > > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C=
""#D#I#T!{#O#S#T=1B(B)
> > > > <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> > > > Subject: 6.1.107-cip release
> > > >
> > > > Hi!
> > > >
> > > > I took a look at -rt releases, and...
> > > >
> > > > 4.19 -- no suitable -rt
> > > >
> > > > v5.10.224-rt116-rc1 -- just wait for release, then do corresponding=
 -cip.
> > > >
> > > > v6.1.107-rt39 -- can I ask for corresponding -cip, or do the releas=
e
> myself?
> > > >
> > > > Thanks and best regards,
> > > > 								Pavel
> > > > --
> > > > DENX Software Engineering GmbH,        Managing Director: Erika
> Unter
> > > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > > > Germany



