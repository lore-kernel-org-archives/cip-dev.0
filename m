Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB1C677C4
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 12:47:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.6844.1749646024534535748
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 05:47:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=jO9EQ8jL;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1749645999;x=1750855599;bh=pE
	Gvjs8ekVGQ5RWzIbkX6ypdMNVlKFOs8JhR/N0DE84=;b=jO9EQ8jLboHCvjcvkYV+VawnNVmxuOOC
	6VaUc+dArqozELFxUgSRam3qeGKxQV7CWlj28QPAYt+kBybdTRHk+klTMvssqU4/Hqs4666vsY3Kj
	j/VK4WwE9n76DtZf03hzvopXlr00WV8piCCjB3F0gj+4ggHSwb/uk3mHrwRP+FhJr0aQp9Ce8NcG3
	bE9KRsx98D9ybb+BJox+QjfoE7KgDKYKbLCX5QK1wvHaz3XtE5T+r22WSkDGA95Hv7MZgoZBwPisE
	J4ONTS1pBOa+XnWnbGP807+vn2JLTB0lkBPbXwFMI8ipPKn/z+ps8iGv//XnVNgJ7Gn+X1qHuYY6T
	5g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 55BCkcIG3967145; Wed, 11 Jun 2025 21:46:38 +0900
X-Iguazu-Qid: 2rWhSHZE7IwxZBSVM2
X-Iguazu-QSIG: v=2; s=0; t=1749645998; q=2rWhSHZE7IwxZBSVM2; m=08wfAY6SjGcvswOCHyd8ZxF+LEsc9zel1SOE13phatk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 55BCkZZX3260749
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 21:46:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV5uqbooYr6y/gmT5N0lflFNeBJ7/VnWN/4A4rT5aZsJEbNW9bNBWsLRMLZfh6K5174LILKqTZx/BpGXftaUZT72lx/p35Yg9Ek3pPUEnn5DAnaVPUOP0ddqI9ZNIxbrD9+jjy/SqcW9fpEXWH7PYZeiFXixNXTNlSMOiyQLqG7n1chPYIAuJOHeOGPkJwly4/S6N06JSBSwpuIEiI5hySZ4Tr/nWdB2E9hjM/5vRpj1vk2w+dp27AUXLJx5sIndM02iSFw7hveStX3eLLeAm13GDZCPP4kopyuvxGlV1OKnm1tlWZVSLLBTqz/pZIbb/t7W+z8OCD+s7i8Lxvl+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUnob0XWAuD0/rohbNYvHeBIC6tOpzd/QxY/Qq8abF4=;
 b=a+g9hlVei/0FFYyEQXkmz3M2tD2aX8f1y97xWF2S7rqIxEifUb4a6kAVzdA5IsW8j8RGR4DVf5aZLYXybC1bnjBwVZfhoiu1dO6O6mrHrX4oZQtvsD7iuEoRZzvRb0xNFk+7k6tBhBO5tAYngpLDf4yilmjmsENGnZRDiz2jYQVvgbqPEfQD4okL/fu6pDWgkXFCLzQUpTKXQkVbV53hGTL+HTxKqno0MXaBT5EkyvVZjss3J4+U/CU4ZodLHoeEOhxUqq0tKCWgzHrOFB4W/IkYr7LkTr6DauN9XIglbb8XDu2P/dbIq7zaim5iRnHYUM6WyfQdXiMbkpIfDwbMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.141-cip43
Thread-Topic: [ANNOUNCE] Release v6.1.141-cip43
Thread-Index: AdvazrVlERCOV82HRSuff54FReUX1Q==
Date: Wed, 11 Jun 2025 12:46:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB1480882E574195DDB203A01989275A@OS7PR01MB14808.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|TY3PR01MB9967:EE_
x-ms-office365-filtering-correlation-id: 9e663897-c69d-4b1b-dc31-08dda8e5fed6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MWgrcVBudVR2QndBVm5hVzRSZVRWbFVGZFNjMUVYUHpTZTlONERYUUxI?=
 =?iso-2022-jp?B?SHNvTUtQaG5hS2hWUU1YK1BNQnFGcnQ0bktKK2ZHeWlxY2lrenQ4U1Rx?=
 =?iso-2022-jp?B?ZHZPVjE1S2Uza013cjhGUk9TNlhqRFhjT25tSGRpSEFuaWM3Ym9qZTZx?=
 =?iso-2022-jp?B?enBmMGdKQmtNQmZLTndxT2tRakFaWWxhTENRcmQ2NTJzdCtuaWduREdz?=
 =?iso-2022-jp?B?UElHU0tuM3hIcXdzT09pVFpycEh3YkZmRFhCUnUrTXh5eitIbGpjOXdQ?=
 =?iso-2022-jp?B?M0RuUlhHMFNITlNONngwUFlDdWVqKytXSDNQdUFaQWViUHdiTVZ3L2dF?=
 =?iso-2022-jp?B?T1ZIZTAvSEpydEdjOFgycXRUaUlES3kvdWI5MUtnUUZjWGRpbkNwTUx4?=
 =?iso-2022-jp?B?U29oVmFBSmVxTThQNW9wMStiSHNVQ3k5VGpkeXR5UmFLVE1hVXhUNjBW?=
 =?iso-2022-jp?B?a08za25yb3FYZ0RHRHRNQk9ock95ZDZpcm5wT1JhNzlNdFkvQkZWT0hU?=
 =?iso-2022-jp?B?djNTQzlyRFlZb1lTd3VDL2RQNktaRzhoSnNXbnpZdFNrSHk5bWhGYSs4?=
 =?iso-2022-jp?B?QWJOWFJXZCtCUlFUNkJVR1hVL2ZqSG5tU2dBVVJjdHN2T3lZQmxTY2RF?=
 =?iso-2022-jp?B?SGpoTlhDanlZYXRLN3B2MGZNUjRzTjQ3dGZIY0doVXRXUlZoa2RiZzVU?=
 =?iso-2022-jp?B?NC9kbXM1ME12WXFCaWltS1M2Ni9rWnJqRTV3djVwUks3d3pCd2M3QlRl?=
 =?iso-2022-jp?B?ekpZWFNic2pUR0h4cVlOREE1YmFMODZJM2lWMHh0NjFTbUlnTkxvRmhh?=
 =?iso-2022-jp?B?SUlRYk1IWHNCTWRObk83aWh1Ri9xUkI2Z0QxT1N0eHp0VEd1TWtzaitZ?=
 =?iso-2022-jp?B?RldISTdsaFBJQUZ3Ynh4M2wrWlJjUDIrRVdDUEpOYmZ6d2dIbnpMVTYx?=
 =?iso-2022-jp?B?aVZ6YUJjeTRVczJzeVkveCs1akY2NEVJS05PaVpQWE9NdEt6SHlLY1E2?=
 =?iso-2022-jp?B?QTJuTUFBcXZMbmxRc09WYmRkb05DYnYwZlZFNC9Yb1VUN2tTUGZjNExD?=
 =?iso-2022-jp?B?WWxnVFNyZUM4OE5nRFRISmNIejlpbzg5VjY2SmIyK0xvWjltU1JTbStk?=
 =?iso-2022-jp?B?K1F6UVZuVURDanlzbFFkdlJwbnhyK3JBdXBKNVM0QzRYdVF6R09pN1FZ?=
 =?iso-2022-jp?B?eGdmSXlubWNpTWp5VlRvandDN2hOSDUrZFlUS0xER3NLcEZoWjhYQjFt?=
 =?iso-2022-jp?B?N0xQcEpvamFsSDVieGhyZUhpTmxjOU5EVCtpbm1PSkFjVTJpUzdWbnQ5?=
 =?iso-2022-jp?B?Vnl6ZUVSZXFRZVdIcUFsUlVsNnJFdTVBRHFTSnpTRXNjREtKTkdyZFRo?=
 =?iso-2022-jp?B?K1RBT2RESWM2WTV4MmZOY2JGb00xZlpGSEwraTQ5cStscDN5OEdTaUNy?=
 =?iso-2022-jp?B?SlV3QTNYbC9ENlIrR1RFTXJQVGNQdFVpUWNmVGNZR1hNQXN5M0JwZXd4?=
 =?iso-2022-jp?B?MjR2dkdqSFpVdEtPZ3B5MDBzY2pzQUl4b2RVdFh1OUJGN0dtcjZ0SlRq?=
 =?iso-2022-jp?B?NmNSVERvNGVOVmgwakYrOWxVUERLUklFTElpOWJLNHJQZG1Sa1VPQ2dQ?=
 =?iso-2022-jp?B?VXNYb3daTDg5UlkvQkx4Q01CUkJwTnlxRWFXWXJRSG5KOG1OWHZabVVV?=
 =?iso-2022-jp?B?LzdQTTRPdlJkTHlKVEEvaDY2RnVHZ3hZVmdDT0FHMUYySVlpd0NFUmUr?=
 =?iso-2022-jp?B?bFY2VFBma1NHUWMrZWx1WGFjdTloZHJHMUJuWU5JZGdDcVl1MjRFVzdn?=
 =?iso-2022-jp?B?MmtqV3J3aTROdmhyOG5ZQ1JTN3gzTU1ndXdZS1NuR1Q2UHdIVmdYMG9o?=
 =?iso-2022-jp?B?eVlMREdHMDd4dlVlL3kzL2hyUndmNDE3TEdTV1NnVDRPck5jdHZYVDdP?=
 =?iso-2022-jp?B?eUpaNSs1bUZDdVRpV1JpUWxEcFI5elRvSDVMcTZKRkc5anJHd2V2bGcy?=
 =?iso-2022-jp?B?U3FvZFd0U2czTTVId0RJdUhUdEdjeEFmQmprY1FyZTcvaVlVTXdXY3RD?=
 =?iso-2022-jp?B?bVBRZ2piYUNpQmlXOWtuUlMvd1FBd1phTmlyVGdRYkhTcUI0c0xhRE1N?=
 =?iso-2022-jp?B?NE1zdFNRUzBrWHZBOW90M3AycnNWenhHL2l0L1dNVytxVUQ4ak50UEFT?=
 =?iso-2022-jp?B?Z1NnPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZjdIOGFNMWlFVGNzNDU5T1RPYlRtWHA4clc5dFpibTlKSzVZejB6VXRp?=
 =?iso-2022-jp?B?UTJDSUg3bm9HbkcrRU1mMy9SQ3pka2ZLSVpjai85RlFrWXdqcUl3d1lD?=
 =?iso-2022-jp?B?eWhQQ0xDK0pWUUJ6L0s1TSttNm9FNmVCei9lQm1TMXBIREE4OFlJc295?=
 =?iso-2022-jp?B?TW9yOFk4a2tEcEpTR3Z0WTRtVFVlZy9SYW0wRHkyaHorU1RVSnJDK0pO?=
 =?iso-2022-jp?B?UGxvZUlFaEdweS91YXE1MlRoU3pyL09lUmlzYTVkSzFKQVBnZDBxN0VM?=
 =?iso-2022-jp?B?Y2g0Tzh5bEhNSjJpWVN5Z1BYK2dDWFlhVUNsd3ZGdnFYWlpIeXpQa1NG?=
 =?iso-2022-jp?B?S1lmci9nQ2FXTUhsSnlqbXY0R01BeGlKWVp6T2xGdWlPS04zWFVrUTJ3?=
 =?iso-2022-jp?B?MWEzOHN2a2NXakdPbjB3WXNEZWFqVHNqWnZvNWRvY1ZuSTh1YTU2ZnBz?=
 =?iso-2022-jp?B?bFdXWm1wUzNXMnZUdE1VMkFRRFQvZWFWWkcwY2RxS3NHSmpWZ21sTEFo?=
 =?iso-2022-jp?B?TkNiSnZIUUc2Z2lsMEN0bUI5Wk1pVXRKMjN0QVkzaUx6WTBLQzVrK1h2?=
 =?iso-2022-jp?B?T2pyQ0hmZHB6b2JadkdEKzRnNDJqcHJ2SjBFSWI4UWNRSmJwVFFpVmtW?=
 =?iso-2022-jp?B?aDlvUzA1dm1TWjMvS0dRYXdDaUk2L0xPL1dyQUtnbHFDNlk3dGJGWWlM?=
 =?iso-2022-jp?B?M1o2TzBRSnE3VnROREZCcTJHMGl2anFweEFXQ2t4alAvUGRZKzZsdnBE?=
 =?iso-2022-jp?B?RU0vNEJhKzFSU2pOSmZGMHNvZDAzM0FDNStTbnI5YytWaTRLVUgyQk9B?=
 =?iso-2022-jp?B?Z1FBeWpmN2x4bVVyUy9pVG1UV2d2MWdSQ1lkd2dmbFNWTko0VHZBQmdN?=
 =?iso-2022-jp?B?ZG9yMU9iMnk0bnJLSTY4endjbTRUc1ZjVThaQTUzTVFSdldmWm5Fa2Nj?=
 =?iso-2022-jp?B?d2tMOExHWXlsQWxRc2RHMmFkU0E4MVNMT2dsdnlnZXlVUDA3dlBRaDBp?=
 =?iso-2022-jp?B?SnJwUmtNUUlEZHFsQXZlZ3pmRWRzV29RT0ZlY1RvUjNKQWg2cHk0TzY3?=
 =?iso-2022-jp?B?cUxvS3lhTlZkZXBzejFiZ280QmgvVklDZVBuYzVDVjZmcEtnY3lXZGtG?=
 =?iso-2022-jp?B?cFduOFdiNlFsemVrc1BObW1QS3pLbmlPY0dwYUV4dTYyRHFZMEZiSjRT?=
 =?iso-2022-jp?B?c3loTXpZNUFTdGNkQ0J1T2o1WmFNZGo2VHAwUVdjWm5kQVA3cU8wRS9K?=
 =?iso-2022-jp?B?bEgvWTJjU1VRODF5WUhLeGJ4dXgvcWRBNHBHQzkrdjBCUlZLeUFwZWRI?=
 =?iso-2022-jp?B?ZEREeWdJOWpjTGd3MzZYU3k2VlFKcnpXQ1BaQlM0dnJYcjc2bzJIN2pP?=
 =?iso-2022-jp?B?WndoeFVOd2VpbUdUckJCTWptSmFUa0NsWE5SeDFRRWgxMDRRYWJ3NHI2?=
 =?iso-2022-jp?B?eVNNTlNmUWxCVEtIVXRCaXJJcTJOYkFDYXhHZllXNThUTHdUbGN1WjNB?=
 =?iso-2022-jp?B?TVJNZDdaaUpOYWEza2xlKzlwWGppTGdudTZCRVo2eFZSQ3UzWkxRMnpV?=
 =?iso-2022-jp?B?dFN5cEdsV1FYYzFLZTQyeW0xbXRSc2pGME5jRHJPOHNralBqTWVGOGtB?=
 =?iso-2022-jp?B?U3VxRXgwL3UwZ3ZJeGRvUzNZZTRhamtYdTEvRmxmTk5pcHRBd0pPdXow?=
 =?iso-2022-jp?B?NFF5QVlMaTFiUjkraGxXVjA5TTVpQjNFSUk2ZjN6QmFDZUJzdERhRVF1?=
 =?iso-2022-jp?B?Z0Y0SGVrSjZwNDY4WmVreGkzR3ZMK0dIZE44K2xMZFlGbFVzOGFYUEJZ?=
 =?iso-2022-jp?B?enFJSzBYWVRVQ1VRd0l4MU01cUFYSHVORGRYTTVTc0lLYzdiRXlWUGZy?=
 =?iso-2022-jp?B?NjlsTVBLeTl6MVc5TEQ4Y3ZPd1h3b1V2bnV6elUzSEd3TnV6K1BJSTZ1?=
 =?iso-2022-jp?B?dm5IaGlMeHNjUEU5Q1B0cmlJdk1MMnhHNEhPMnNCVnFMQmRSZW1vL3RO?=
 =?iso-2022-jp?B?ZnB3UVphNGU0M0VWODRmVndRWjBtSW9aWE8xcnZOdjU0RDIrQXV0RGF1?=
 =?iso-2022-jp?B?NmQvbXZnUmtkRDdYVlF6STBUSnhmNktQY1RxRFU4S3lWZ1hDUk9Bck1o?=
 =?iso-2022-jp?B?d2s4cmxuWEc5TURHNkNTWUdlMXdsVlBLN1Bjb0dyd0xCNWI4TDJFZEt2?=
 =?iso-2022-jp?B?YXM3andJcWhVSmxacUQxL1lBRy90aWg3SDJtRXptNjBzdTJpaXRnZm45?=
 =?iso-2022-jp?B?R05FZmhpNGQyQWIweTdmVHduZ2IxcXJUQmp4N3pINUMwcmVmbWQ3OU1q?=
 =?iso-2022-jp?B?NUJHQnZFSEJydi8yelpoV2hhS0pRdVBFL0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e663897-c69d-4b1b-dc31-08dda8e5fed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 12:46:33.2793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPXnLvQ8EJD4XsFJRrdaynWKqOs6DlzG4wNoLLS4Oj9A+jaevMweSmpWWgW+5DUNR1HODTjbKIobdtrAbv+evHWxv2x00ylQtQeRYRipkZ/1gRRsjchhZ62vzICaOjfa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9967
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 12:47:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19027

Hi all,

CIP kernel team has released Linux kernel v6.1.141-cip43.
The linux-6.1.y-cip tree has been updated base version from v6.1.137 to v6.=
1.141.
This release includes fixes for ASoC (SSI) and SCIF for Renesas ARM64 SoC.

You can get this release via the git tree at:

  v6.1.141-cip43:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      63685e8e8122881a1e5eec654bf602d262b595f7
    fixed CVEs:
      CVE-2025-37913: net_sched: qfq: Fix double list add in class with net=
em as child qdisc
      CVE-2025-37909: net: lan743x: Fix memleak issue when GSO enabled
      CVE-2025-37929: arm64: errata: Add missing sentinels to Spectre-BHB M=
IDR arrays
      CVE-2025-37928: dm-bufio: don't schedule in atomic context
      CVE-2025-37991: parisc: Fix double SIGFPE crash
      CVE-2025-37921: vxlan: vnifilter: Fix unlocked deletion of default FD=
B entry
      CVE-2025-37915: net_sched: drr: Fix double list add in class with net=
em as child qdisc
      CVE-2025-37901: irqchip/qcom-mpm: Prevent crash when trying to handle=
 non-wake GPIOs
      CVE-2025-37890: net_sched: hfsc: Fix a UAF vulnerability in class wit=
h netem as child qdisc
      CVE-2025-37897: wifi: plfxlc: Remove erroneous assert in plfxlc_mac_r=
elease
      CVE-2025-37911: bnxt_en: Fix out-of-bound memcpy() during ethtool -w
      CVE-2025-37927: iommu/amd: Fix potential buffer overflow in parse_ivr=
s_acpihid
      CVE-2025-21839: KVM: x86: Load DR6 with guest value only before enter=
ing .vcpu_run() loop
      CVE-2025-37905: firmware: arm_scmi: Balance device refcount when dest=
roying devices
      CVE-2025-37932: sch_htb: make htb_qlen_notify() idempotent
      CVE-2025-37930: drm/nouveau: Fix WARN_ON in nouveau_fence_context_kil=
l()
      CVE-2025-37912: ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fl=
tr()
      CVE-2025-37990: wifi: brcm80211: fmac: Add error handling for brcmf_u=
sb_dl_writeimage()
      CVE-2025-37924: ksmbd: fix use-after-free in kerberos authentication
      CVE-2025-37923: tracing: Fix oob write in trace_seq_to_buffer()
      CVE-2025-37819: irqchip/gic-v2m: Prevent use after free of gicv2m_get=
_fwnode()
      CVE-2025-37936: perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for gues=
t with vCPU's value.
      CVE-2025-37903: drm/amd/display: Fix slab-use-after-free in hdcp
      CVE-2025-37914: net_sched: ets: Fix double list add in class with net=
em as child qdisc
      CVE-2025-37902: [REJECTED]: dm: fix copying after src array boundarie=
s
      CVE-2025-37994: usb: typec: ucsi: displayport: Fix NULL pointer acces=
s
      CVE-2025-37964: x86/mm: Eliminate window where TLB flushes may be ina=
dvertently skipped
      CVE-2025-37951: drm/v3d: Add job to pending list if the reset was ski=
pped
      CVE-2025-37997: netfilter: ipset: fix region locking in hash types
      CVE-2025-37969: iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6d=
sx_read_tagged_fifo
      CVE-2025-37947: ksmbd: prevent out-of-bounds stream writes by validat=
ing *pos
      CVE-2025-37970: iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6d=
sx_read_fifo
      CVE-2025-37962: ksmbd: fix memory leak in parse_lease_state()
      CVE-2025-37963: arm64: bpf: Only mitigate cBPF programs loaded by unp=
rivileged users
      CVE-2025-37998: openvswitch: Fix unsafe attribute parsing in output_u=
serspace()
      CVE-2024-28956: x86: Indirect Target Selection
      CVE-2025-37949: xenbus: Use kref to track req lifetime
      CVE-2025-37995: module: ensure that kobject_put() is safe for module =
type kobjects
      CVE-2025-37959: bpf: Scrub packet on bpf_redirect_peer
      CVE-2025-37948: arm64: bpf: Add BHB mitigation to the epilogue for cB=
PF programs
      CVE-2025-37953: sch_htb: make htb_deactivate() idempotent
      CVE-2025-37961: ipvs: fix uninit-value for saddr in do_output_route4
      CVE-2025-37972: Input: mtk-pmic-keys - fix possible null pointer dere=
ference
      CVE-2024-53203: usb: typec: fix potential array underflow in ucsi_ccg=
_sync_control()
      CVE-2024-36927: ipv4: Fix uninit-value access in __ip_make_skb()
      CVE-2024-26783: mm/vmscan: fix a bug calling wakeup_kswapd() with a w=
rong zone index
      CVE-2025-37967: usb: typec: ucsi: displayport: Fix deadlock
      CVE-2024-57945: riscv: mm: Fix the out of bound issue of vmemmap addr=
ess
      CVE-2024-53209: bnxt_en: Fix receive ring space parameters when XDP i=
s active
      CVE-2024-36903: ipv6: Fix potential uninit-value access in __ip6_make=
_skb()
      CVE-2025-22062: sctp: add mutual exclusion in proc_sctp_do_udp_port()
      CVE-2024-35790: usb: typec: altmodes/displayport: create sysfs nodes =
as driver's default device attribute group
      CVE-2024-26807: spi: cadence-qspi: fix pointer reference in runtime P=
M hooks
      CVE-2024-46751: btrfs: don't BUG_ON() when 0 reference count at btrfs=
_lookup_extent_info()
      CVE-2025-21645: platform/x86/amd/pmc: Only disable IRQ1 wakeup where =
i8042 actually enabled it
      CVE-2024-26618: arm64/sme: Always exit sme_alloc() early with existin=
g storage
      CVE-2024-43840: bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG
      CVE-2025-37992: net_sched: Flush gso_skb list too during ->change()
      CVE-2024-50203: bpf, arm64: Fix address emission with tag-based KASAN=
 enabled
      CVE-2025-21931: hwpoison, memory_hotplug: lock folio before unmap hwp=
oisoned folio
      CVE-2024-56655: netfilter: nf_tables: do not defer rule destruction v=
ia call_rcu
      CVE-2025-38000: sch_hfsc: Fix qlen accounting bug when using peek in =
hfsc_enqueue()
      CVE-2025-38003: can: bcm: add missing rcu read protection for procfs =
content
      CVE-2024-56758: btrfs: check folio mapping after unlock in relocate_o=
ne_folio()
      CVE-2025-38001: net_sched: hfsc: Address reentrant enqueue adding cla=
ss to eltree twice
      CVE-2025-38004: can: bcm: add locking for bcm_op runtime updates
      CVE-2025-21816: hrtimers: Force migrate away hrtimers queued after CP=
UHP_AP_HRTIMERS_DYING
    added commits:
      CIP: Bump version suffix to -cip43 after merge from stable
      arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
      arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
      arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe d=
ifferent switches
      arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
      arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
      clk: renesas: r9a08g045: Add clock, reset and power domain for the re=
maining SCIFs
      arm64: dts: renesas: rzg3s-smarc: Add sound card
      arm64: dts: renesas: rzg3s-smarc: Enable SSI3
      arm64: dts: renesas: Add da7212 audio codec node
      arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
      arm64: dts: renesas: r9a08g045: Add SSI nodes
      pinctrl: renesas: rzg2l: Add audio clock pins on RZ/G3S
      ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
      ASoC: dt-bindings: renesas,rz-ssi: Remove DMA description
      ASoC: renesas: rz-ssi: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
      ASoC: renesas: rz-ssi: Add suspend to RAM support
      ASoC: renesas: rz-ssi: Issue software reset in hw_params API
      ASoC: renesas: rz-ssi: Add runtime PM support
      ASoC: renesas: rz-ssi: Enable runtime PM autosuspend support
      ASoC: renesas: rz-ssi: Rely on the ASoC subsystem to runtime resume/s=
uspend the SSI
      ASoC: renesas: rz-ssi: Use goto label names that specify their action=
s
      ASoC: renesas: rz-ssi: Use temporary variable for struct device
      ASoC: renesas: rz-ssi: Use readl_poll_timeout_atomic()
      ASoC: renesas: rz-ssi: Remove the first argument of rz_ssi_stream_is_=
play()
      ASoC: renesas: rz-ssi: Remove pdev member of struct rz_ssi_priv
      ASoC: renesas: rz-ssi: Fix typo on SSI_RATES macro comment
      ASoC: renesas: rz-ssi: Terminate all the DMA transactions
      clk: versaclock3: Add support for the 5L35023 variant
      dt-bindings: clock: versaclock3: Document 5L35023 Versa3 clock genera=
tor
      clk: versaclock3: Prepare for the addition of 5L35023 device
      clk: renesas: r9a08g045: Add clocks, resets and power domains support=
 for SSI
      arm64: defconfig: Enable DA7213 Codec
      ASoC: da7213: Extend support for the MCK in range [2, 50] MHz
      ASoC: da7213: Avoid setting PLL when closing audio stream
      ASoC: da7213: Add suspend to RAM support
      ASoC: da7213: Return directly the value of regcache_sync()
      ASoC: da7213: Populate max_register to regmap_config
      ASoC: da7213: Initialize the mutex
      ASoC: da7213: Add new kcontrol for tonegen
      ASoC: da7213: Add support for mono, set frame width to 32 when possib=
le

Best regards,
  Nobuhiro



