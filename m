Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D824AC27C77
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 05:23:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.4586.1718342613975995152
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 22:23:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=izhWE5Ft;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1718342603;x=1719552203;bh=Elvnh13DkBiV1nwpnbMHksKwdDq9bLizc/YjS7s
	+oz8=;b=izhWE5FtVMNUj20QLjsDh8iS0MpqsslkBPPe1/IUtW+K43Bv0icqNPtiLrLyo5paTnu6T
	SMXuqaBSUvNmaMktkIUb4sDjJM/q1HCq2VxG+5u2Z+eplXKMmT2oCwnf3z6g/WC+RXYY0js4rCox5
	TaN9MdsZS+RDTVALyKKBmZuwKdK67Ni1q2yDdq5N4I6EEpg8b6KvetSgBBdZlsUc8kHoOEYHeiGDH
	4AdBhEk23O1vA1Ek83yssY8j1/T4aOh2Hq7UaQ5RflgC980czZ9YIggGBNTbiKsJPOylnYzQ9nodg
	6j1AWk+7WfKOnJuYS032OawDdShXy31ODPC3M2igKA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 45E5NNff973532; Fri, 14 Jun 2024 14:23:23 +0900
X-Iguazu-Qid: 2rWhyQ028mEn8csKJh
X-Iguazu-QSIG: v=2; s=0; t=1718342602; q=2rWhyQ028mEn8csKJh; m=isL3XALBmZksU8VfHvqdSk7+PFj8zJLza5WbwMYrSjA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 45E5NL372158428
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 14:23:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7pdYQ/UwrTytNnIFtrlOS8jMCy1Jsxn1h7HfKmeqSVXWeDDkVBCYSbUU5RGRh56dUJbXL/09TOiYsRfbUT3E4xDjgw0KS6TiHROLL6oZAJB9GN0TZuA/rTwThwMdKyvZ4nLdfqraKVl4kUz0APDYGklDRmgobRPf0eYtm9L+MnwsfE6st+QQJm4I1+3pe17NOQNIPz9r8oLWH7gmzYg+ozVXQA1LX78DL+CL/rOCjlvUedoHlxzautw6j3DFvDqSARgrhqwvH5dJYrGAIPsIN6Top844RU/UwWryvqOrOYAuSFI6Nb6A02acPNtuBR6lRShic4g7qzz++Wyb8TqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPRW+0cC+X0R3gcGCpSINn9MCneBVyj+ajXiMCdooX8=;
 b=bkzv2Kvo9DghP9fHwkVFrP3DkI8F/hkmxNUoybBYrD9YxGwH5wJyFU4V9PqDkyjYz2nnJWPoIzBsAVZ3juxl38wJdqlorBeuiSRjvaGeFeQLe9wdInpbi5CiRI+JgsR5SMlUZKf4g0U5MibvFFNqeiU3FEzsehHyACz4z4qUDlQNQO3e3Quengq0JNTHxxlOYjPHfs1m/KZXoSy2OAYfzBfLA9qL/6RlqWNntMZDgXZM/y43BZlbZs7Q8eBpS470DA+JHByK2U8KVkRnWU8fdIrLPyoVnJY+HIr9OG3w7K/4RcHnsVPxjmBzbOlPdCLU53PMspYLzXPXUZiHR/Zvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/7] Fix USBHS pipe configuration
Thread-Topic: [PATCH 5.10.y-cip 0/7] Fix USBHS pipe configuration
Thread-Index: AQHavX8bvE6sTflLV0mEpc9J8l8lP7HGuGHQ
Date: Fri, 14 Jun 2024 05:23:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63889B571C233701108910F892C22@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYRPR01MB12143:EE_
x-ms-office365-filtering-correlation-id: 9143571b-0a64-4bf1-e05e-08dc8c3219f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230035|376009|1800799019|366011|38070700013|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cEc1SWZPMVFtbE1RbmpiQmIyeCtLMzg2NytFS3o4dklFbDA3bno0M1VR?=
 =?iso-2022-jp?B?bGp3bEUzWTZqbkVvM3JuSTNPR0ZUWUJkcVpWcTcvRENHRlhITzhiTUVB?=
 =?iso-2022-jp?B?TXBGSVRsKzFNWGQ2WVFqaW83V1FIMm5FRTQyYjBwRG9OT2pKcFYxTlg0?=
 =?iso-2022-jp?B?U0NnK05nNXRZdndHbFh6eTBieEcxRzVCbWY4S2tGbFNYcGZ1T245dCsv?=
 =?iso-2022-jp?B?ZXJVaFV3QVJNSDJTVWtoYXJQWU1QZ0kxY2hJbkJpQ25QV3JlSzdmUGZi?=
 =?iso-2022-jp?B?aUVnUEFFcU4xTVNYWDdqVGpRRmdobE9KckJkUDhFdzFTa3ZLNi9aS0Rv?=
 =?iso-2022-jp?B?c2lZQ2FYdnVQeTEyNW9EZmJpK2NVQXY2Q0ZZNUlNSkxQb01paGZyYzlL?=
 =?iso-2022-jp?B?R1Z3azliNzM5cVFva20xN05RN1Z2M0tqOS9LWk00ald3L28vdk5Mc0ww?=
 =?iso-2022-jp?B?STNkUTk5V0tmTW12Y2lpQkNiNlFHQjFRYXNUOUhUS3Y2NmNUZGFEOGhQ?=
 =?iso-2022-jp?B?ZVRNR3Z1OFZPQjlZTnFhdHkzeXBNeWl1QzdxekIyTkE3aTdCWm9VYXBY?=
 =?iso-2022-jp?B?eWY5ZlVqOUZNWnpyUytNQ2c3MmhncUhSMnU5NjNkc3loaHJjaWR1WDIw?=
 =?iso-2022-jp?B?LzFwYXA0Q1NKQVNYS1A1eGx0TWc0Zk9HemU4NkZIaTFLVXR2UEVXL2t2?=
 =?iso-2022-jp?B?cm1QQ3VjVWRoMVc0L0ZSY2w1UXIwcW9aOU5ZcEVkWDNHZGQwRG43OFVl?=
 =?iso-2022-jp?B?dXB3cFduL3hLWFZSdmlvSEk0OVptUVp0V1J1RTNObFNpcHpCWS9Sa09E?=
 =?iso-2022-jp?B?cnVSNDZvY3BydStiUGRHTVpTMmszbi9YTHR6UVBjQ05hV2hoYzBqSXIy?=
 =?iso-2022-jp?B?UEN0VGUrdzFjWjJPdTk0RDhHTTAveWZ2cmFDMTJCM0FYelJ6VFNTS3FQ?=
 =?iso-2022-jp?B?eFRKZ3lONEhuQ1ZBZWxGUlBva3VLZTZKeTc3NDV2MlRpVEhKcUFwaVd4?=
 =?iso-2022-jp?B?djVvdzhRQ2tjb3pkMzBKNmtwbitoQnNyV09BMjdQamI4VjhuNFg3bVY3?=
 =?iso-2022-jp?B?UngvcHZDdWFndVpDV21VQmVETXZZeGtyMTJtNjg0UnU5TVRiZ1ZQNFB4?=
 =?iso-2022-jp?B?bkU3U2NBazRXRHRTajZGRU4yQnVNTllja1FRUVpybGR2V2RLQnZPNWl1?=
 =?iso-2022-jp?B?MEJyTGgrMmZTSmtBclhabGVMWW15NEhZeVNTd1hTQlBMTjMzUDMwNEtp?=
 =?iso-2022-jp?B?clk1cmdtMXJCcjJLTnlZMEdKR3V1MlpKbG0yYVFYdmFhOHUrOE1CMDZX?=
 =?iso-2022-jp?B?RDVBY0ZGeWdOYnlzUnVrUThDaTRBVmlHTElmSHNTYTNjVXlXakNZWk0w?=
 =?iso-2022-jp?B?T0srOWo2bm15b0phSTZZTThwVGt4OXZBYWlWOGJYbThkdHBVZjQzK0Jx?=
 =?iso-2022-jp?B?QWc1OWI1MFFFNGkvWkNLTHpTUlhEMUU4Y0Vpbjk2cXIwaTM3MU5MZ2hW?=
 =?iso-2022-jp?B?ZitNaHdUNENwaDk0Y3pBdmFiR2FLeFlBNjJXOWVXSmp4QzY5WUpqVTJr?=
 =?iso-2022-jp?B?M3ZYUStLZk50MmN5RnhZR2oyd0xrYmRlaFFHRG9wcUF6R240WlFtQXV6?=
 =?iso-2022-jp?B?VTVtbzNpbElvRkF2TUNOdFVTVm9oRDQ1U0I4eUVCaTRxcmVvbGJyMEwz?=
 =?iso-2022-jp?B?RUQyckJvZ2hYSitEU1Q1YzRyYTNBdCswbnRrS0ZPaVZ6VW54SUNKK0xy?=
 =?iso-2022-jp?B?VkhKc1l6emZmNzBETHpPS2JNTU5mQTdVTmp4dE45a09HK3pGd0c4SVpO?=
 =?iso-2022-jp?B?TFQvN2NTYjJySmlrWkJEczB0V3lOVDVCazR2cE9xSnRpWkhMUW16VzJr?=
 =?iso-2022-jp?B?R29YWUlQT1J3US9EVDYxaVgxZnMwd2hJMzM5Z2dQRFNEZmo2MmFzdnlr?=
 =?iso-2022-jp?B?SE42OTFzUWJJcmkzaDN3QVlRS3Q0QjBTSk1GNmZYV2o3azNQUExlRUVZ?=
 =?iso-2022-jp?B?TTlPRzZRSHA5MmRrK1RldnNUSk1uT3dBMUFaRUdXdkRoRGJjS3RaNlJ5?=
 =?iso-2022-jp?B?ekE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cWFvRHcyeCthQmlqQTVXQVlKS3VVaWYyN1o2L0oweDVrVDczZ0FCenJ5?=
 =?iso-2022-jp?B?VWdCVHoxUG1OUk81SWJCTktBd3pWb25kUFNaczlkWE5NRk8rS2h3cnpW?=
 =?iso-2022-jp?B?TFlybDhCOVJDK0RxZ1MwOUo4ajZSWDZjUlVFRzlUbG9xZFh5cm95allw?=
 =?iso-2022-jp?B?U2V0L1RKZHVKY0d5S2llclBCU1lnL203TzA2R0hTMW1jOU02bVFhSGpm?=
 =?iso-2022-jp?B?MlUxcGp5ejBWeXNjekpvbFl0cDVhQzhwc2I0L1Aza0lxYkYveG53a05C?=
 =?iso-2022-jp?B?QjU2TnZGWjRSaFVtOU8ya1RsM0FxUmI2NHcwSWwwK01JSnZaa3VaVkZt?=
 =?iso-2022-jp?B?QmhjbS9LeXVmc2ptcDArbUd5WDJMNkRRL0hRY2pCWWJtODk3U2JING5i?=
 =?iso-2022-jp?B?eVRIb0VMV2NBMVBMSlV5OWtJSTgrdldHQk5YV1VvWHJ2NW9lbjVaRlpk?=
 =?iso-2022-jp?B?ei9IeXdOY0t1RmRNdCsyTTJDVUdyRnlVSXJPUjBrNnJIL2NqVWNTbzVn?=
 =?iso-2022-jp?B?K2ptZE0vd2ZTS1RrTW9oV01XYlJleGZOR3lLN1BIV1UyQUtyVDVPQXNv?=
 =?iso-2022-jp?B?ZU9sYkhsS2hrd1pZYStpei9mZHFhcTVQdi9BMkRUNXl6S0s3eEdVYkNs?=
 =?iso-2022-jp?B?QkRjN3kyNlU4YTlmSGp4OEd3elBwZElhSWttd3o0cTFaR0tJdERtU3c1?=
 =?iso-2022-jp?B?SGJNVThhYkJJRU1UeDdIR2FaMzhUVGMvaUJQTHpXQXQzTlN6QldpKzlS?=
 =?iso-2022-jp?B?RVJnbENRTGdhZ3NNRml0UVB5d0puY21rclVjZWMwUXBja2ZENDh0cnBI?=
 =?iso-2022-jp?B?bGF1aUQzS2tzYUYyb1h5Y3R6VndLWjk1OFBqTDg0eTM1T0xzclZnZE8y?=
 =?iso-2022-jp?B?Q0d2K29lZThrRHdIeTNZd1MwU1dYYm1wY3JkQ004WEpMMEFWaFc0akZh?=
 =?iso-2022-jp?B?NWduYWFmM0lrL0lHNElBbnhENkQ0NWxYWnVrM2kxUkt4cjBtYWZwa2RD?=
 =?iso-2022-jp?B?T1JNMkU3RVdwcW1vbDhRTnB3bmpoZnNzN2V0dW5aVXFFeVlEekF3ZlFJ?=
 =?iso-2022-jp?B?WHhXOFZsdEd3b3B2Uks0RytnSUhzSkF5YU5zdnRzUFdKdFBuK1JyMEJZ?=
 =?iso-2022-jp?B?N0JkeXBVRktjdjQ4S2cvaC9NclRlVzU0K3dPZzIzcFliREs2OTZqRU1F?=
 =?iso-2022-jp?B?cjZ0QzJraTFHdlFSSUd6a0R2SWozY1FvTXhvcjBKWGZBamdRRlYxb2Fq?=
 =?iso-2022-jp?B?S1RyNzRiMlQ1SFJOaTBpRnV4RllGNU01TTlzeUpDSWdqN3RHeFBUMFlj?=
 =?iso-2022-jp?B?VjdtcS9ES2VnQ2JZbW51N2tBZi80eUdmN0tWOW5pVkhBRXd2WVh1UHg3?=
 =?iso-2022-jp?B?THFuQlpvZldXQ3hFRHdXRVo4WUVSYkZZNXp6Y0x3aFhxNVNIY2JoS2lU?=
 =?iso-2022-jp?B?VEY4RldQSGFvT0lFdlU1ZFhXZ05Jc0MzLzQxMko2WjVYTW5tNHhoVDg2?=
 =?iso-2022-jp?B?Z1lBVVM2dmVObnhEamhvVTE2WSthbnc0OHZwT3U4dnYrUE9FSUdYWVdj?=
 =?iso-2022-jp?B?Tk5DL3UxSVp3SjJCRUNhT3NBYzNGLzUrb3ZyMzRLUmMyRTZoZlZBV2Zt?=
 =?iso-2022-jp?B?TDdqMEcvUXNpZXY1M1cwZklQQ0M3cjdaSWEzZks0TmN3OTZSWjBWU1BZ?=
 =?iso-2022-jp?B?LzhSK2tMNDVIN1BzMWt4V2FnOTNiM0ZzV2h5eUNac3JaczBEOTZueGcr?=
 =?iso-2022-jp?B?M0t5a1VaY21BbzZyaklhQngwMUtmRkZESk1HajJTWDhsTEVwbGJMVUJ5?=
 =?iso-2022-jp?B?QWRQYUpOV3pRTTVDZE9YMm9lRlpvUlV3dDI3WG90dVdRSWE1WElTVHMz?=
 =?iso-2022-jp?B?amNiVU1obkR4a2JiR1FNVGpPbFA2MmV5Q21FSERWZ2ZrWVlQQVlsUERv?=
 =?iso-2022-jp?B?czJaUjNUQ0VybkM4UHhYMXdyMldOc2tCWEZHREM3Q2RrOFpWdlZaaHdG?=
 =?iso-2022-jp?B?elZCYlVVZCtja0lKdDRCdDRHaHNrVkNBZDEyNWZRLzM1d2I0WkZrSGxW?=
 =?iso-2022-jp?B?eXlrazJzS1VjSStDK1ppMXZhZTd3SGJDNnc5VEdUMlBtL0JJZktvQ2JC?=
 =?iso-2022-jp?B?VFQwNzRIUFVpeXBtTVp0SjRHeW4yM3FYbzUxaFYwc3YvS3ZSSHZVb3Yy?=
 =?iso-2022-jp?B?NHRCbENodDFPSEh1R3hlZ0tlNUlpNFhGM1NQU08xMnNMUWNUSFhxZ0E3?=
 =?iso-2022-jp?B?UGhPWVhDWVlTYzY4SWxSMVcxRmVydks3MjdJdWVRcjRFRTRTbDJxenZW?=
 =?iso-2022-jp?B?RVBWSVpScG1TOGIzWXV3eGhLSDdkd2VOeHF1cHE4WXpkUDluS0tOY1RP?=
 =?iso-2022-jp?B?NzVSSEttK1B0UHNnV2d2RGxFbHN5OE4vTm8rZjhhRGpRZ2V3VE1UY0pF?=
 =?iso-2022-jp?B?aWdHT2d4bzJlR0FPUlNDdnV6UkNtc1lhN24wPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9143571b-0a64-4bf1-e05e-08dc8c3219f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:23:19.1320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y41Y/UzZfCgxeUfwAe8cou9ApNPl8z3j1rJCtjo7kIwID79Mma2u+ISIP1Gqfov6b5Jg/0OgHCVXBp7Ad4cPgSScQDQ/Zk7hnmnEcviYOZT6XWAyxrTOL7m8ah2zuLiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12143
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 05:23:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16225

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, June 13, 2024 7:47 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 0/7] Fix USBHS pipe configuration
>=20
> The USBHS IP found on RZ/G2L SoCs only has 10 pipe buffers compared to 16
> pipe buffers on RZ/A2M.
>=20
> Fix the USBHS Pipe configuration
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (6):
>   dt-bindings: usb: renesas,usbhs: Document RZ/G2L family compatible
>   usb: renesas_usbhs: Simplify obtaining device data
>   usb: renesas_usbhs: Improve usbhsc_default_pipe[] for isochronous
>     transfers
>   usb: renesas_usbhs: Update usbhs pipe configuration for RZ/G2L family
>   usb: renesas_usbhs: Remove trailing comma in the terminator entry for
>     OF table
>   arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family
>     compatible
>=20
> Lad Prabhakar (1):
>   dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
>=20
>  .../bindings/usb/renesas,usbhs.yaml           |  8 +++-
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  2 +-
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  2 +-
>  arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  2 +-
>  drivers/usb/renesas_usbhs/common.c            | 41
> ++++++++++++-------
>  drivers/usb/renesas_usbhs/rza.h               |  1 +
>  drivers/usb/renesas_usbhs/rza2.c              | 13 ++++++
>  7 files changed, 49 insertions(+), 20 deletions(-)
>=20

I reviewed this series, LGTM.
I can apppy this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


