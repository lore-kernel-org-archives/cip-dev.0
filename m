Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DEDE77173
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 06:12:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.94823.1733724741751359787
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 22:12:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=FzTgkRsp;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1733724732;x=1734934332;bh=PLcUDgPrkhOD/lPaCsffbe6kNpx4CGWbZfbTkO7
	+wMg=;b=FzTgkRspqtiimoDcXYSLLvzt62jbBWkyAlm7RCZvtIrLgPl2c7Kb5UEqWj142twQmO9EA
	41q99PNpHM1DtX4uoHWzqUOiw8UKlp7PiUVs8Pwl9a9Ed53veolVKK2zGGVcgA+3Db9f9tLFtJedJ
	1++57Nmfa15q25CA2j4WysuK/xe/rCOndg+9cvAUgnHtJlVbLZnB4u295zUmvBVLd/zCa8RerjpJQ
	Z3unitExaesWrI7Gh3Wqjryou4Rg6ZOeGHGWmd7pM8t/VG4Sn64W4Z4qWpYK9jeUNAITlxbdflv8y
	9GkLPv4NOLdK8hkRoOshgp3/H+LXL41zQH4t8xoOpw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4B96CCpd339451; Mon, 9 Dec 2024 15:12:12 +0900
X-Iguazu-Qid: 2yAbRDIdrlne5b9FFw
X-Iguazu-QSIG: v=2; s=0; t=1733724732; q=2yAbRDIdrlne5b9FFw; m=AQqphT5ntNaTNavUYpxXpi/BhjHY4TtHeZTZ+qQiBtk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 4B96CABr2227823
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 15:12:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXPlq55zclYMxIxAheZ2MrN5K5SmSAR5p7podC2a3Tqr7fOZ7aNR04WAfef5OQAuXqdd9tFaH6PxMfG8yfBVvOYUYYfDnOQF6euS9sYMI8AeDYL5z5exwriif5C8l1LQXdwREjpUMQjkKTo7bIdHOx6wESq0fjWqfmWU243pmxI27eArRgfSQUDLTqRXBhXpr/SxezuMNVEBQ5eB7zXMPB3+l+niNO5vTIt8nYW+3YNdXgnWahlfwf8241cjF8F0mKM9U4B7R3uYPIO4kGiB4B6yIL8EF0kPNlDyT/kylxLS8DNQROxfdTIGIE7RweXgwOTgv0vfsFXmsGGIFF1P2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4HvY5dzsCZ6SQpm/9gVYYr01SYu16ddfJv5i1u4Qjs=;
 b=CjOY/TisQdaantWDbeEv1UCtbL3ngIuCXNxhDi31FaNY0mE9pXGwswe7OpPdMpKHqS52aZaQ5QRNHvqcf/PjX14bfkfNLV48fKfbhU1FnxDHcxeSvdxqJrGs4l/+JGtFwZwQB8EeCHGLgGUERWqITmQt19rqMNFEmU1pI3g3e39TzMvsD3/hdwgT5BCqYPocZd/BX0u4gtz39lp9XhCzACuoDNP+xhXFRzZxevc+zp0M/RzZN/M125LYGv5Z5nHzAA9SMGIUsiYis8wxlvtoArwyAGPnRVgycGiZP/h9mvXfXAhO7kiQw4Pz/nkD5oHQ1lIfuclDCgNyBiymN2p5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
Thread-Topic: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
Thread-Index: AQHbR77ad1VaFxKZRk+n3x+FC0/OW7LdcdeA
Date: Mon, 9 Dec 2024 06:12:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63885D768D71D58AC391B09E923C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYVPR01MB10668:EE_
x-ms-office365-filtering-correlation-id: ae7cf97d-9759-4565-6e9e-08dd1818691c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RzljNFF2aVN4ejRYVXd5SFh2VWtrRlJOaWN2NXVkdUpuM3FBR3IvdHVF?=
 =?iso-2022-jp?B?bmlNeW1PYTd1VmdCaUN2S01maDRQV1Z4SE5BYmRCcXJBZEh6RFp5TDdO?=
 =?iso-2022-jp?B?NEdmalZ2aXdVVTlhTmNjeHNVNmF0Q1BOb3dQMy92QVNISlppc0JPY1N5?=
 =?iso-2022-jp?B?bUdyMVBCcWpNSnJRTkt6dUJtUzFvSWVyWHdqMHZRSGk3MXhqWmlmNTVz?=
 =?iso-2022-jp?B?ek42MHREUFg3cHhDd0dwWGx4Vnh3dHJuaEdLWisxdTlFcmowT2VOU01h?=
 =?iso-2022-jp?B?ZHNvSGFvTmpIV2pFSFo0cGpsOTdWUExLY2tGSmNGZzlkQ2JMZTMzL0pX?=
 =?iso-2022-jp?B?NUxYKzRLc2pZSkJVcENPQ2lZVVZqSC9ub25zOTQ3V25UMkRmUTY0enpx?=
 =?iso-2022-jp?B?V3Y4aTZOV0sxcGRhbElkNUZkbWJ2WXgzQ0VaSllkRDRFY3BXQlRseEZq?=
 =?iso-2022-jp?B?ZU9MTXVlN1F5S2JXb2FURFFQQm13VkFxTkR1Zk1EME5lbkpvOTV0b0RR?=
 =?iso-2022-jp?B?V3gwYWxUU3F2NzF0clVRNjhoK1BkQ1RPOVZpMjBPamhFbzNMODU4c3ZT?=
 =?iso-2022-jp?B?NHNnWDcyNENnQ1o4UTVJRDJGOGVBaUdXai9Ibkh0QWhTL2dKcHRSb254?=
 =?iso-2022-jp?B?b2dJcklMVzl5K3U0WFJibmxFTkpsU1ZSMnE3SG4xZlhZMXBwNTlIMjl4?=
 =?iso-2022-jp?B?WnpwZnBlakhjc2llWnpsR0twZk11cXRvVHlYOUJ2ZEQrTlhtMHBMMDdM?=
 =?iso-2022-jp?B?eVRlVFZ0bDZqQW9PMVF4SnNzd2RpaXl3NGVpeEdDK1NidkU5c0lERitM?=
 =?iso-2022-jp?B?NmZJc3pjdnB1VnhCQW10TllabE9pNHJTcXlLS1lsbld2cVQwZ1NuemtE?=
 =?iso-2022-jp?B?djZKWDVqcE81VVZQdGlVckxwMWloR2NWM3c5V20vd05aMW81bUpKdTFu?=
 =?iso-2022-jp?B?Yjl4aENMbSt0NG40SEp1VFI1NkZsQm5La2JsTXBSZVhVQ20vcDFpWXVY?=
 =?iso-2022-jp?B?cy9UWVVMZFczVzJFdmJtTW5QSGYwOFU3bUNzeWpHKzdNUEZtV1VpN1E4?=
 =?iso-2022-jp?B?b21pby9ZV3V6VjE3Q0VVaE9OUmdoL1lySWt1THJMRlpERDFaM0dXL2Rk?=
 =?iso-2022-jp?B?c2gyRjBiOWh5aWthL1lvbjlFdm5ranRSbldncDEyandBNW1IZld0M29S?=
 =?iso-2022-jp?B?ZmRlUlV1VE01T3lPbDh1aEpXOWhKME1hdmFjOWlhc0V3QjcvYWpkUU1I?=
 =?iso-2022-jp?B?RGdmYU5VaHVDZTcrUVVxUjJ0MjFkazl0cGpnTmF5Ui9NZjNiVXRzNXd0?=
 =?iso-2022-jp?B?SWtKRnZiNUU5Y05jenV6L3JqaVM5bTZNZnVCbGUzSjh5RTFhcHExelNY?=
 =?iso-2022-jp?B?VUtNUnRGNGM5N0JXdFJORCsraHBtNk56WlU5dmNTdUZFMVFtVzM3LzIz?=
 =?iso-2022-jp?B?UE5pNnFUSElCdllBb2dpcW1wY3JlNXRFT3UvNnQzSnF2dHVCNldLMk50?=
 =?iso-2022-jp?B?QUVLMGxCMWU4YnVwRjNtOTNCRHp6Y0xWdmN1L3NVV3h6MDIrYkVhblJw?=
 =?iso-2022-jp?B?ZzZzVWMzRmt4Wm9FdWs4YW5nRlVuaUJpZEI4RjZQN1p4YWppdlRuaXJv?=
 =?iso-2022-jp?B?T092aktLNzZXckVZT1Q1KzY2NTRDcGMzYXRjcDFtWGxJaFhvekMya0l2?=
 =?iso-2022-jp?B?YzhnTUJjY1Y0K2lpK1p2a09LQ0JxL3FBN091d0lXazkvdzRNa3czTTBr?=
 =?iso-2022-jp?B?V2JZZWFRY2ZwV1loaW5kRnlNaEYzejlkK3hWSDB0MTRCSTY3NUpoMzZv?=
 =?iso-2022-jp?B?WFl6RGYwclZkTW4vODFIQnF0aU52OWZoSEowcGNTZjU3cllkYnVoRG9H?=
 =?iso-2022-jp?B?djkvU214TFY2cHZHYW80c24yTE05eDQ5d3dLR1ZqQS95QjE5Y0E5SE5a?=
 =?iso-2022-jp?B?Z0xJNzZETGFCZW1yY0ZCWFNCZGozWjlWbUY5WUJabWMrTTljdEgxMTJC?=
 =?iso-2022-jp?B?T0p5bW5MQ3pzTlNESWlCTllIc1RYcnp3K012Z2toVWN4Yk81NVFxdkkz?=
 =?iso-2022-jp?B?c1pBY0JnbytuUllXVDNyVnc5RklqSHM9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OU03eHp2SG9rMjVMUHpEUW9hdlVCVllJemkvZmxkUzBiWTZiMEZFM1pS?=
 =?iso-2022-jp?B?L0JJaEZUNWx0dlZmTUQ2R0dMSDZBSWY4WVRvN3lpaUVlWjEwSUZ6SVBL?=
 =?iso-2022-jp?B?YW9sZkdLbWt1Z3J4bWZvYXJlYmVISTdDOGZBQmJmR0NRK3BsQWVZYThI?=
 =?iso-2022-jp?B?Q2t1bnh3M0ZYeTM4OUVrUXVWNkx5RlVVbmFiVG4zcUhrQXlUN2s4UmRY?=
 =?iso-2022-jp?B?Tm9aSDlCZUs5U0JXRko3Mk9lRldWY1Q1UDJvY2xlc3E2aVZmOWJzcUxW?=
 =?iso-2022-jp?B?TWszalh4NnRpRDduNlIrOEJ6NWVQQ2tPQXYxNFk1RHk5ZlhxWjlCS3ll?=
 =?iso-2022-jp?B?cCtnc3RqblFHYzdDSi9ydG1VL0FTL1QyclpIb1lwU3d6Y1plRnZ3RmhG?=
 =?iso-2022-jp?B?eHR3Lzgwb241WUdjZ0JlVTZ2dXhSa2YyOGpnUFM1UnlhUC9JcWJ2NzFq?=
 =?iso-2022-jp?B?aG54clZlNXVENkxHL016c1d1Mk1BMFhNb3ByN05mR2oyVndWS1RVNDRL?=
 =?iso-2022-jp?B?b3JYQmVjZXp2OE5jUmRORmhJbFU2V3pGVERVaWtzVDhkczlUeU9hMXE4?=
 =?iso-2022-jp?B?M1ROY2VmN1paWmVsMjk0ampiN3pjRUxieUJmcTZIUXdSL0NJc3lveXpB?=
 =?iso-2022-jp?B?aFVoNXJ3NmtKeEFOdVNaeHp1ZVFwaHNQRVI1dVh2ZVRTVEJmT1BNOWhv?=
 =?iso-2022-jp?B?SlYybmtOQVYvTHhYVWR3NkpMeC9Tbk9VRUZjM2pVUWRuZ3dwNE1YZTdR?=
 =?iso-2022-jp?B?NnRJNXFtcVpNcDAwNGZrNmdzalZId0Vaa2NDSTAwdC9xWXBuTWFxN3R0?=
 =?iso-2022-jp?B?dFlDc3h6SDQ3YWdrbmJIRmlETk05dW9EaXRXcjJuaUhpV0FXKzNITm8v?=
 =?iso-2022-jp?B?MmdySS9TdnZXeDQ1UENxS3BIeUs1VllGWng4Vy9UOTR2QTZhR3VlSTNP?=
 =?iso-2022-jp?B?aHF1RzZzWkNkSEtURGwwTlVSVmx4NEdVUlZGMUxuK0lOWWYzQlJwdStv?=
 =?iso-2022-jp?B?NGtEVjNtZ09BMnp1R053akl4RUtLU3BmR1BjS3hoSGtYcEpPZTExVXlD?=
 =?iso-2022-jp?B?c1Ewa1JqTXd2b1ZQRmZDbnJXL2ZESEszZkZEUE95bGx1blVjRkhzc1Rr?=
 =?iso-2022-jp?B?MmsxUE1XVS9tK1dvWkpodHlKOXYwd1dnZ2NLT3ZNT0c2WkozbDJYMnhk?=
 =?iso-2022-jp?B?M3BhNW03Umg2ZUFVM3F5U1NDVmc4N2ZXL2ZWblhON0VuYXFFUnVBc0M2?=
 =?iso-2022-jp?B?NXd4OVorSGFqN0RhNDV3cVJ4VTBDamRpNWFDOURiY2J3U1NTak92YmtD?=
 =?iso-2022-jp?B?UTcrcG1LWmRZODNaL05jRWR4aE9pc1d5eEhKU3RFNUgzK3MrTXN3Nm5M?=
 =?iso-2022-jp?B?Sm9oaGtXRUg4cXkyK2xyZ1BZZVJsSTJZcXA0OGdwTU53cis1Sm1XK1N0?=
 =?iso-2022-jp?B?aUV4RHBGNjRlWk92NXN3Y1NINm85Qzk5Si9tMTVLc0JCK0ZMZDl4NUp0?=
 =?iso-2022-jp?B?ODl6R2V5ck5keGJEeEJYL2lxcE9iVzIrMzJ1c1ZKRFMvdXo2UnUwODhk?=
 =?iso-2022-jp?B?aitTZ0xNbmdFZThPcVd2RnJodENHTEw3RmQ5QzMzQ1dBd2ZmRkdsUzVw?=
 =?iso-2022-jp?B?Yi9FZWpwaUhaTXBkbVB5cGh1Q1VkdXdIeEdoa3FDYk8yLzRhbkRmbFpi?=
 =?iso-2022-jp?B?Rjl4eE5pTFNWVnE5NkRhMjkyUmJCQ05jNWxFQnNtL1dtMmk3NGE1SFRS?=
 =?iso-2022-jp?B?YWxMU2R3U3lIblBEa2tNaExxeWtoNWk5QTBuTGxhZGdaaW16bnFrbVlP?=
 =?iso-2022-jp?B?UXRaRGh6Y2tLalRlS0tnTkZLY09PS2hDNGxIOXFIRTRseEIxWGNMNW1x?=
 =?iso-2022-jp?B?b01vNWxYc2JQQzFTZitZdWQwMnFSaFJlejJwTThrb2RNWEltZzVBWFM1?=
 =?iso-2022-jp?B?Y1VndnZid0FCWFZoV0dxZFkvOWk4OXNMR1ZlMmVpQnRRV0ZYaVRTMG9n?=
 =?iso-2022-jp?B?RHNVdkU2ZkdHZzhsVHQzUEN0RjJhcEdxT0RrcUhTb0RuMlZwczdlYWtE?=
 =?iso-2022-jp?B?N2pieGlJcmh4NTJaQWZMRFNCWTB4VWp5U294cEVVYm9PK005S2NxSFl5?=
 =?iso-2022-jp?B?d2xJTFkxVHFRTTBPWW1xUWVLYXd6Vzhqc2lralorUFQ0TmYvcjVpMzZZ?=
 =?iso-2022-jp?B?aDIzZyt0QUdmNEFGaWs1ZDZTeld4QThvRDFFNkhEQ21vMlE2UFFueG1U?=
 =?iso-2022-jp?B?N0QwSHV0TlhtQXBTZlBFd01Cc2pMM2xZNHMwUWVaYjN1cFhKaFhtQmVx?=
 =?iso-2022-jp?B?MU1Ld1VDN3YwTi9FZ3BkQlFHVDN1NUhrVHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7cf97d-9759-4565-6e9e-08dd1818691c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 06:12:07.7982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1s5jkb/2fnQ/bMP7Xskw6skWg1fNGx1QutCl/+OoxO4ktZBv+36VL9ekVjowP3pdVsQPr8e116TKd2C9wvqA0K2dMv6IWS89acpeKUELtw8mEDOcAnJCs0hN8eDQsGVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10668
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Dec 2024 06:12:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17377

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Friday, December 6, 2024 6:11 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
>=20
> Hi All,
>=20
> This patch series aims to add RPC-IF support for RZ/G2UL SoC and enable i=
t
> on SMARC platform, along with enabling tx width to 4 on RZ/G2L SMARC
> platforms.
>=20
> All the patches have been cherry picked from upstream kernel.
>=20
> Cheers,
> Prabhakar
>=20
> Biju Das (5):
>   spi: rpc-if: Add missing MODULE_DEVICE_TABLE
>   memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOVF
>     pins
>   arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
>   arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
>   arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table
>     for spi-nor flash
>=20
> Cong Dang (1):
>   memory: renesas-rpc-if: Remove redundant division of dummy
>=20
> Geert Uytterhoeven (2):
>   memory: renesas-rpc-if: Always use dev in rpcif_probe()
>   memory: renesas-rpc-if: Improve Runtime PM handling
>=20
> Michael Walle (6):
>   mtd: spi-nor: sysfs: hide manufacturer if it is not set
>   mtd: spi-nor: remember full JEDEC flash ID
>   mtd: spi-nor: move function declaration out of sfdp.h
>   mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
>   mtd: spi-nor: add generic flash driver
>   mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver
>=20
> Miquel Raynal (1):
>   spi: rpc-if: differentiate between unsupported and invalid requests
>=20
> Wolfram Sang (1):
>   memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
>=20

I reviewed this series. Looks good to me. I can apply this series if there =
are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


