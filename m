Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B03C83F1A
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 04:44:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.6457.1752209078862004152
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Jul 2025 21:44:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=PX95mrVr;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1752209054;x=1753418654;bh=RZ
	gGfiFWFoiJLQQvtqxSFQK0i3wSDTQA9TUvL7VELFE=;b=PX95mrVrk7JqnJqHVTl9HidslmmDhNPw
	ZZIidJw3MWRONN28w9irPZ7S8wYrm3B5htlzw5QLX2jRosOd9sJIjQLOYQfCm+G6EJitPAjjFuj9L
	fiZqncY0my6n/+7ajXlSOLm6DultfFv5RHV7J5K5dvEhdiQUjw1CKIU9oViXIqaHm0h1OhAwd5tyP
	NhsruVKUpMKAdIB4btCQeiX0P2eT6SVTuz0rXFlckGmbgiQBJOdAiM+nn7iDUQa++rHostEtXV9y2
	3JwQB5iEEYfTunKVSMg6P02511x895SWUKdlhExlBui33SJu/oMF+RWbq3enyM0AOCBB117xjTGcS
	rg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 56B4iEnR4077459; Fri, 11 Jul 2025 13:44:14 +0900
X-Iguazu-Qid: 2rWhEqwpmwIVVoUWQg
X-Iguazu-QSIG: v=2; s=0; t=1752209053; q=2rWhEqwpmwIVVoUWQg; m=nzV3C7w77ybbSzV6QkBir0YHkMy/M+eptDhi/VMSav8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 56B4iBon2090767
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 13:44:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gke7488tbsHrmyQyYFGAYyt2SFRfHy6X9rg4AOxukZYEAGi9yUxBLZCgiZQZQx3ohsaG1gIH8+eNYr47F5584qaY4kA7zYJxhZ0Iy+adxAFes6DhAeNLMhwCZgywc1Czh6ZB9Fm1pSzOuoSojzazl+ac4rZe2l1+gN1lsguFYY+img+6qwZQiBDRN1Vt6gMUGt5RT4fGnEw5WhZQPW8Siqr0uHBRTlfBj4ART+mlBCUln+0ehU5ZV0TVT4vRY6WJbaUtjjIPdqDCuaK3N3pD/L+MvyRoDIbCNETRwQZRmILByvB7mRTYS3V9n6KbDKlHxADloY1kBhMGhfsz1JwETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4pPi4WVw1Sh0eboY4VkTxQfNblT9cWQCSUrkj90nE4=;
 b=SgkATrJBpjNrqB2iX4ecwWs7L+hUrlU9UyM8pt98wCnssk87jDYsULKNnlJEdMo6Uo5Mt0/Q/NfuNVLK9ThdZxeLj1xIStE0oHkdixf9KtPI/9JY9+6wxxE+a9k6aPoMp/+NS+xfCluaU8Z9WgodSzU9OL81ttbDUYJVD6Oewz8EyzIdEWkqE9+rvGEX2NcxQ1UbKrWK2hZPUM6o4fGMSnv7WMO0P8QgFWzSw1Y+SG8ebJbQjHrB7P2zvwOZInOvitVjxgjvz4sn9hb6ZYd91qA6k1dZRIowRIlEXLJ8eE+c5WHpjwU0ZQEe2XFapqViYaP2l8P89m0wTtowfW40Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.12.36-cip4
Thread-Topic: [ANNOUNCE] Release v6.12.36-cip4
Thread-Index: AdvyHmD5QHl3BZa/SFaP34rLi+0KsQ==
Date: Fri, 11 Jul 2025 04:44:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818ED3DB8F4F76E14873441924BA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10716:EE_
x-ms-office365-filtering-correlation-id: aae8db53-c275-4f63-8c20-08ddc035935c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?U0pqdTZIV3htYXA1aWxoazRDdDkrV0lXNkxERXNwVWRCTUxxRk1qRVRO?=
 =?iso-2022-jp?B?LzkwYk1FTGdoZXljeE05d2lQZXdmTGtNcHI3ZnpIbkhlSkJha2ZXNGR6?=
 =?iso-2022-jp?B?UXR5ZmdrYUUrVnRrVFUyNlVlZmtkUGtRRDBkWkplY1VzT2UwbGFHaFRp?=
 =?iso-2022-jp?B?RElYRmI1ams5Y05pb3NKeXdmODhNYTNTc0FSaGVFY1Q0UFoyNFRFbDI3?=
 =?iso-2022-jp?B?VWhYZ1RaNzlyTWdIMlp5ODRDc2NsUENWd1g2VE5VeEVQTVc5RXEwR1BZ?=
 =?iso-2022-jp?B?WkJEOEJyNnByenlIZWlIdktnNWhiQjVUUFJqWW9XSENubVZ5bnEvd0ZT?=
 =?iso-2022-jp?B?MXN5dmlVb2dENjR1bGUveWgxcjVBWFFZSHpCZzh0dUhUSURRN0tUaU1x?=
 =?iso-2022-jp?B?V3IwdnRtQ3ExS3UwWmxQVkV0ZWdxMGhMVStOS2VFd1pRdFBDVmM3dUlp?=
 =?iso-2022-jp?B?Vk85d0ZQdGFqc3Z3bGYvSVZDY25JUnVvWFpmclBxckpqTWhudDZpbjNv?=
 =?iso-2022-jp?B?ajRqMnNpUWUwTW53dHZCYWtkZm5ZQ3lrMGxGZTRDckF0cm5la1RIeGsr?=
 =?iso-2022-jp?B?bXBRWEhCeDBYSm52aUtQRkMxS05vZ1k2WGFRMVNvVTI2OGFkNjdwbEt1?=
 =?iso-2022-jp?B?QjBjRGJ0b0FxdW5vcmZPeGNCSHVsQ3RpM1UycDhoYjFqd1hlTGZEOVJ6?=
 =?iso-2022-jp?B?OWtVeW9VVFJ3UjFZejRrckZ1WEZxdDdmYWhYdHA0NmFBTXN2Ui90U3Rl?=
 =?iso-2022-jp?B?WlRrSnBpVWZ6ZjJsdjNyMHJESERGUmNJcTBsVU9EcDlFQlZHRVpNaGwv?=
 =?iso-2022-jp?B?Q0ptWW1rWTNTOG9KTU5xVjg3a3ZYeVlEZEQzc2NoTkdLcERtV2JQNUtU?=
 =?iso-2022-jp?B?K0pFY3FZV2pORzVaVDg1SXBFWS81S3FTbU1BREtSLzY1N1hnSlpjaTBZ?=
 =?iso-2022-jp?B?Z1YvOEZTSWFnN1Y3di9QWHJBajJDeUluMGdxdFAyVlU2U1ZGOEF0L29j?=
 =?iso-2022-jp?B?eUIzWFlDNWI1ZlV5ZGkxY0p1ZjdwdjNRb2VML3F6eHBPNWJNSUY4YjA2?=
 =?iso-2022-jp?B?aS8zUkdSWW96TnNObThYUTdEMXRWaTUxOEF1MSsxM2pDSjN2OU16Z1Ux?=
 =?iso-2022-jp?B?ejR5dC9MWjc1Q2hYa2JhQ0ZBM0pWc205b1VUMGdVcCtSMFJQbFBqdjhu?=
 =?iso-2022-jp?B?L2dMWGpIVnZjKy9OblBMYUY4NXpYdExtWG5ydHJ0TG1OdjlhcnUzN0NI?=
 =?iso-2022-jp?B?RkxQbXgyU1ZMQTRNR2lEc3REQXpCUFdzM01kTEdtZzgzR1llL0Q4SGRQ?=
 =?iso-2022-jp?B?MmwvUTBQdXcydVJsZWVLZzZQcFhvTXpLRlFjN2xBN1BMUUtSbGdPZUVa?=
 =?iso-2022-jp?B?TE5UZU1TVXdhRFZ1YUZhQVBNR1pZR0RqVFd1Z3l5MWprVW1HRHVEd1F3?=
 =?iso-2022-jp?B?a2V1MHdSYVJjZ1FvWXE4WDROckxvQmVEQi93V254RFJHeDBMQ1ErVWU3?=
 =?iso-2022-jp?B?UVVveVBWbVR0ZzV2K0Z1N1ZHdGhITlc5TzBCSEt2bFFuTmkzUFFLRHI0?=
 =?iso-2022-jp?B?NFV0T3pVaHNwRjRRcytEWjZwTkgwaWlUc0puREZudGdNVzhEMEtOQ3N4?=
 =?iso-2022-jp?B?S1hSbnVHWkkrcW1Oa3hsa05QNm9HM3haeU5MTEp5THlwc2FNS2FCVGpL?=
 =?iso-2022-jp?B?bjFwZHFoak5qZFUrc2dPTmZLejI5MEoyT1hBaXRvRnRRTFpTL2E0M0Z1?=
 =?iso-2022-jp?B?SmJKd0U0VDhUTmJKSDR1c0d2QXBpL0tFVjZxQWZ2TUJ3RkZXVGcvUWky?=
 =?iso-2022-jp?B?N3JHWVlKQ2NUOWJHUXMxQjZUVm1yY3Y0aXowSG5sRm1sZ2RzaEtSNmg1?=
 =?iso-2022-jp?B?c091UUFGZVlkSURhOHFiN3lIODRxcGNSbU1CLzlhMmpydWFUaFoyYVRu?=
 =?iso-2022-jp?B?d25idm1FczJpU1NWTUNUOERRN3NTYmV6OE5jN1VQdHMyVXg3RlkzanlX?=
 =?iso-2022-jp?B?SnUzYlAzQUhHRWRBd2RoMWI5VlFQcjBudEtuNWhpSzlMb0VFTy92Ri9i?=
 =?iso-2022-jp?B?bWZXb0VzV1BuS0tpSUJNdkpCSEdIRVArU0VaaDgvVkdjTGJxWjBTU21N?=
 =?iso-2022-jp?B?Q3FrK21HMUZ6OEhGcE1XKzJqUWR6V2ppWW00Z0JiZGIrYVI3L1k3V1NG?=
 =?iso-2022-jp?B?dFVRPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a3lBSTMrSld4ZElISExLdElzOHJCWE1mcUk5c2JmWEVTQ1BzYUxGV1px?=
 =?iso-2022-jp?B?R045UHRFWWRNVlNlblNvZG1nRXd6S0lBaFd1WXVqK0EwMkIzelppajll?=
 =?iso-2022-jp?B?VXY4L2ZmUjhPTHRENEVRQ3hzYmFnSGhrVHBhNXoyM2UvbzlTV1ZoSjEw?=
 =?iso-2022-jp?B?U0QyT3ZnVGM3b3J3K0dxaFkxRVVMMm94TnNxNzhUQUtQS0xEd0prTnNp?=
 =?iso-2022-jp?B?dm8wajV3MDNQZCt1VmVpeGNkTmJ4K2gyMllUUTVOV0JQYVpYcFhqczBT?=
 =?iso-2022-jp?B?M1hTZDdwaFZlSmNSQ3pFWnkrNzNOTERIQm5OZ2g4dHg0Tm5YckV2WnVv?=
 =?iso-2022-jp?B?Y0JoRGxmSGRYRFJjci9Xb3VUbkMyazNqQUIzaVlFakZWNnJIdkRGbmh5?=
 =?iso-2022-jp?B?Qm9GMnJPTkpzNTlqclYvOW43emd0Qkg1ZkdzRFFNTmpObW1FQjl6ck9I?=
 =?iso-2022-jp?B?TnYxS3hEK05uRDNRVm9US0VwNmdKWU1MRW95NStTRmRST3hqamxBNkE3?=
 =?iso-2022-jp?B?MFlsWnVQa09WQWFpaVlackJmV2k1UkZaS3R2Yy85TFBEdzQ4UGptTFUr?=
 =?iso-2022-jp?B?SWJFb0ppZkpEVHBrVXhYUDdXeW5CelVSOHJXd0o3aStGMkZqV2dMMnRt?=
 =?iso-2022-jp?B?TFhHYitKVjl6S0xrUWNqN2prRlpkS0FtbmVWekhmaTEvRHlvWEVpd25U?=
 =?iso-2022-jp?B?WGZ0QldBeGdkUDZidmtWa3gzWnJrUjVjYnIvNFY3TUZLcEhkQXZmSVNn?=
 =?iso-2022-jp?B?bGlWREoweG82NUw4WTdmYytreSt4RHJycU5yK0cvZ1o5QnNnVXRSZEti?=
 =?iso-2022-jp?B?dk9oVFlza3lZUHFIcnQ0S2Q4dW9JcjhRU3Jic2s2T0RhRGJrUFYyK3p4?=
 =?iso-2022-jp?B?MmF1a2dZckZBL0NJNGFkVEdpVkJURjdSQ2tWN3BhVjI1elVuRGlzeDNQ?=
 =?iso-2022-jp?B?R2QvVmI1ZEZhT0pJYUZ4eXordk9UWVIrd3lSUkdnSWJ4aUxOYUNmMUZK?=
 =?iso-2022-jp?B?T0NCYjc2Tmhxa0ZBNkNjSWxKNytibGRERnB5c2JEMFJYRlpUcXZ0dkN5?=
 =?iso-2022-jp?B?MkZNeGZxMGhtb2Z5TmNkNW9pVXNyS3ZmU1M3aHByZFMvbkcvK0xkeVNV?=
 =?iso-2022-jp?B?KytJVmgyaHJZWlRMN0FBcXVRcUs4ekl6emw2UmoyYTQzcks0L2k3ZCtn?=
 =?iso-2022-jp?B?ZUhzTElINC9JMkZnSVh2bS9nWEt1MFFzbEJ0RWQyQTR0ZEYvZVNjd0ZG?=
 =?iso-2022-jp?B?UGplMys3VnVzV0pTQ2swMGdZS2pySVZ2Z2EwYStzYUxqQ1JtZXVNbkhj?=
 =?iso-2022-jp?B?djBuSjdJOHhyTVFEZ0s4Rk1lakhNaEtOc1phVytzWG9rbW9Zd3dPbTZX?=
 =?iso-2022-jp?B?ZFY1UTBpekt6YzErMEc0R0dVb2MwOFR6OU85UDNxWjczTzl1MzRGZ1J0?=
 =?iso-2022-jp?B?bzFHemRueThVYUpsbnZLMlVhWi8wczFFQWFJWEE0ZnZzSVVGRUpiZkVv?=
 =?iso-2022-jp?B?MElxa2lyY3VZbnpNd0VPbkF0Y3ZiNmg4aFhjRTM2ZmwvZWtGWU14c2o1?=
 =?iso-2022-jp?B?SGZ1RTdxVlBKOVZNbGZLYnNHVnJ0bURMelFVRVQ4cGRzclFhSXBRNFh0?=
 =?iso-2022-jp?B?Ym9uQlFrZXRjUzBhNFRQTU4zUjkzMDU4NzdsajNIK3RTVDk3UnJRWHlt?=
 =?iso-2022-jp?B?R3hpNVN5Q1RsY3E1ZVFrSDNTRUVmczVxcGNWbUNvRklqci9keTJnWGw2?=
 =?iso-2022-jp?B?VFBGbVN6L3JkSFNITVVVTnlEM0lxVjdVc1dmVUtBVGhYTkxXSTdKbHJC?=
 =?iso-2022-jp?B?OXlNWDJDcUxLeUUreXFQTE1vQ0RjMFNPWWkzM0IwbVpLaEJEdnZ2U0Vs?=
 =?iso-2022-jp?B?RzhrNDluRENDdGhoZzQ4UVFseE1MMjVqeit1aGZyU04wUXdpM0dxcXJq?=
 =?iso-2022-jp?B?RnJJRmg5N2xENG9WWVI4UzhhUU92czRYNnUzQWtiSDhLMEt4ZkxHLzlL?=
 =?iso-2022-jp?B?b3hXOWl0L29yY2EvV2F0ZVhrY1N2VWFNb1BqdFM0N1EreEp4QXp4ZUF1?=
 =?iso-2022-jp?B?a1BGSHZidHhadjM0VFVVckpVbnZnZHo5a1ZZdng0cmVESmhoNDM2cVdU?=
 =?iso-2022-jp?B?QkF3ZU04dUllUmxWcVdBVnhtVTBaUnBmYWxveW5GZ2VlTFlUSUVMOW15?=
 =?iso-2022-jp?B?VktXRHU0dzFORFBlSnUxYzdYNldNNjR5MkNNSjZ5V21WK2FqRjVqaWVu?=
 =?iso-2022-jp?B?dW11ZTlqSXpyOFVqT2FrajhsbE5jTlBlNkdCWTNDTGFkT3VqS3laTFJh?=
 =?iso-2022-jp?B?R0tyRS9MajZ0MXhXcmN0WVB4dFRpSWZoVlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae8db53-c275-4f63-8c20-08ddc035935c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 04:44:09.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIvvfgQqXjZE1QIkMt/lQ50RmrDYmnevH2AGSuByKW0eo5b3IGrB8Z9EQKEvkZs0+BjMKvu5OTFtNCw83H47RmXGAW/8oba+xZwsjCwsVXAKeTwo/RWQ44GeHFojyrBa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10716
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 04:44:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19393

Hi all,

CIP kernel team has released Linux kernel v6.12.36-cip4.
The linux-6.12.y-cip tree has been updated base version from v6.12.34 to v6=
.12.36.
This release included updates to the Renesas ARM64 SoC clock and irqchip an=
d others.

Information about this release is as follows:

  v6.12.36-cip4:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      24cd8155efab47b262747fcae9db7404333c9312
    fixed CVEs:
      CVE-2025-38220: ext4: only dirty folios when data journaling regular =
files
      CVE-2025-38332: scsi: lpfc: Use memcpy() for BIOS version
      CVE-2025-38227: media: vidtv: Terminating the subsequent process of i=
nitialization failure
      CVE-2025-38348: wifi: p54: prevent buffer-overflow in p54_rx_eeprom_r=
eadback()
      CVE-2025-38193: net_sched: sch_sfq: reject invalid perturb period
      CVE-2025-38183: net: lan743x: fix potential out-of-bounds write in la=
n743x_ptp_io_event_clock_get()
      CVE-2025-38331: net: ethernet: cortina: Use TOE/TSO on all TCP
      CVE-2025-38213: vgacon: Add check for vc_origin address range in vgac=
on_scroll()
      CVE-2025-38222: ext4: inline: fix len overflow in ext4_prepare_inline=
_data
      CVE-2025-38325: ksmbd: add free_transport ops in ksmbd connection
      CVE-2025-38190: atm: Revert atm_account_tx() if copy_from_iter_full()=
 fails.
      CVE-2025-38324: mpls: Use rcu_dereference_rtnl() in mpls_route_input_=
rcu().
      CVE-2025-38223: ceph: avoid kernel BUG for encrypted inode with unali=
gned file size
      CVE-2025-38334: x86/sgx: Prevent attempts to reclaim poisoned pages
      CVE-2025-38344: ACPICA: fix acpi parse and parseext cache leaks
      CVE-2025-38208: smb: client: add NULL check in automount_fullpath
      CVE-2025-38194: jffs2: check that raw node were preallocated before w=
riting summary
      CVE-2025-22128: wifi: ath12k: Clear affinity hint before calling ath1=
2k_pci_free_irq() in error path
      CVE-2025-38086: net: ch9200: fix uninitialised access during mii_nway=
_restart
      CVE-2025-38211: RDMA/iwcm: Fix use-after-free of work objects after c=
m_id destruction
      CVE-2025-38198: fbcon: Make sure modelist not set on unregistered con=
sole
      CVE-2025-38328: jffs2: check jffs2_prealloc_raw_node_refs() result in=
 few other places
      CVE-2025-38224: can: kvaser_pciefd: refine error prone echo_skb_max h=
andling logic
      CVE-2025-38210: configfs-tsm-report: Fix NULL dereference of tsm_ops
      CVE-2025-38228: media: imagination: fix a potential memory leak in e5=
010_probe()
      CVE-2025-38218: f2fs: fix to do sanity check on sit_bitmap_size
      CVE-2025-38219: f2fs: prevent kernel warning due to negative i_nlink =
from corrupted image
      CVE-2025-22119: wifi: cfg80211: init wiphy_work before allocating rfk=
ill fails
      CVE-2025-38212: ipc: fix to protect IPCS lookups using RCU
      CVE-2025-38214: fbdev: Fix fb_set_var to prevent null-ptr-deref in fb=
_videomode_to_var
      CVE-2025-38202: bpf: Check rcu_read_lock_trace_held() in bpf_map_look=
up_percpu_elem()
      CVE-2025-38343: wifi: mt76: mt7996: drop fragments with multicast or =
broadcast RA
      CVE-2025-38195: LoongArch: Fix panic caused by NULL-PMD in huge_pte_o=
ffset()
      CVE-2025-22112: eth: bnxt: fix out-of-range access of vnic_info array
      CVE-2025-38185: atm: atmtcp: Free invalid length skb in atmtcp_c_send=
().
      CVE-2025-38226: media: vivid: Change the siize of the composing
      CVE-2025-38200: i40e: fix MMIO write access to an invalid page in i40=
e_clear_hw
      CVE-2025-38188: drm/msm/a7xx: Call CP_RESET_CONTEXT_STATE
      CVE-2025-38342: software node: Correct a OOB check in software_node_g=
et_reference_args()
      CVE-2025-38201: netfilter: nft_set_pipapo: clamp maximum map bucket s=
ize to INT_MAX
      CVE-2025-38189: drm/v3d: Avoid NULL pointer dereference in `v3d_job_u=
pdate_stats()`
      CVE-2025-38338: fs/nfs/read: fix double-unlock bug in nfs_return_empt=
y_folio()
      CVE-2025-23137: cpufreq/amd-pstate: Add missing NULL ptr check in amd=
_pstate_update
      CVE-2025-38229: media: cxusb: no longer judge rbuf when the write fai=
ls
      CVE-2025-38084: mm/hugetlb: unshare page tables during VMA split, not=
 before
      CVE-2025-38333: f2fs: fix to bail out in get_new_segment()
      CVE-2025-38323: net: atm: add lec_mutex
      CVE-2025-38215: fbdev: Fix do_register_framebuffer to prevent null-pt=
r-deref in fb_videomode_to_var
      CVE-2025-38085: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race
      CVE-2025-38225: media: imx-jpeg: Cleanup after an allocation error
      CVE-2025-38341: eth: fbnic: avoid double free when failing to DMA-map=
 FW msg
      CVE-2025-38216: iommu/vt-d: Restore context entry setup order for ali=
ased devices
      CVE-2025-38192: net: clear the dst when changing skb protocol
      CVE-2025-38179: smb: client: fix max_sge overflow in smb_extract_foli=
oq_to_rdma()
      CVE-2025-38197: platform/x86: dell_rbu: Fix list usage
      CVE-2025-38326: aoe: clean device rq_list in aoedev_downdev()
      CVE-2025-38346: ftrace: Fix UAF when lookup kallsym after ftrace disa=
bled
      CVE-2025-38337: jbd2: fix data-race and null-ptr-deref in jbd2_journa=
l_dirty_metadata()
      CVE-2025-38345: ACPICA: fix acpi operand cache leak in dswstate.c
      CVE-2025-38191: ksmbd: fix null pointer dereference in destroy_previo=
us_session
      CVE-2025-38321: smb: Log an error when close_all_cached_dirs fails
      CVE-2025-38217: hwmon: (ftsteutates) Fix TOCTOU race in fts_read()
      CVE-2025-38180: net: atm: fix /proc/net/atm/lec handling
      CVE-2025-38336: ata: pata_via: Force PIO for ATAPI devices on VT6415/=
VT6330
      CVE-2025-38182: ublk: santizize the arguments from userspace when add=
ing a device
      CVE-2025-38231: nfsd: Initialize ssc before laundromat_work to preven=
t NULL dereference
      CVE-2025-38347: f2fs: fix to do sanity check on ino and xnid
      CVE-2025-38232: NFSD: fix race between nfsd registration and exports_=
proc
      CVE-2025-38087: net/sched: fix use-after-free in taprio_dev_notifier
      CVE-2025-38181: calipso: Fix null-ptr-deref in calipso_req_{set,del}a=
ttr().
      CVE-2025-38090: drivers/rapidio/rio_cm.c: prevent possible heap overw=
rite
      CVE-2025-38089: sunrpc: handle SVC_GARBAGE during svc auth processing=
 as auth error
      CVE-2025-38184: tipc: fix null-ptr-deref when acquiring remote ip of =
ethernet bearer
      CVE-2025-38320: arm64/ptrace: Fix stack-out-of-bounds read in regs_ge=
t_kernel_stack_nth()
      CVE-2025-38186: bnxt_en: Fix double invocation of bnxt_ulp_stop()/bnx=
t_ulp_start()
      CVE-2025-38260: btrfs: handle csum tree error with rescue=3Dibadroots=
 correctly
      CVE-2025-38245: atm: Release atm_dev_mutex after removing procfs in a=
tm_dev_deregister().
      CVE-2025-38236: af_unix: Don't leave consecutive consumed OOB skbs.
      CVE-2025-38255: lib/group_cpus: fix NULL pointer dereference from gro=
up_cpus_evenly()
      CVE-2025-37842: spi: fsl-qspi: use devm function instead of driver re=
move
      CVE-2025-38244: smb: client: fix potential deadlock when reconnecting=
 channels
      CVE-2025-38230: jfs: validate AG parameters in dbMount() to prevent c=
rashes
      CVE-2025-38263: bcache: fix NULL pointer in cache_set_flush()
      CVE-2025-38256: io_uring/rsrc: fix folio unpinning
      CVE-2024-58091: drm/fbdev-dma: Add shadow buffering for deferred I/O
      CVE-2025-21942: btrfs: zoned: fix extent range end unlock in cow_file=
_range()
      CVE-2025-38246: bnxt: properly flush XDP redirect lists
      CVE-2025-38251: atm: clip: prevent NULL deref in clip_push()
      CVE-2025-38253: HID: wacom: fix crash in wacom_aes_battery_handler()
      CVE-2025-22101: net: libwx: fix Tx L4 checksum
      CVE-2025-38257: s390/pkey: Prevent overflow in size calculation for m=
emdup_user()
      CVE-2025-21879: btrfs: fix use-after-free on inode when scanning root=
 during em shrinking
      CVE-2025-38258: mm/damon/sysfs-schemes: free old damon_sysfs_scheme_f=
ilter->memcg_path on write
      CVE-2025-38259: ASoC: codecs: wcd9335: Fix missing free of regulator =
supplies
      CVE-2025-38262: tty: serial: uartlite: register uart driver in init
      CVE-2025-38264: nvme-tcp: sanitize request list handling
      CVE-2024-57976: btrfs: do proper folio cleanup when cow_file_range() =
failed
      CVE-2025-23155: net: stmmac: Fix accessing freed irq affinity_hint
      CVE-2025-38249: ALSA: usb-audio: Fix out-of-bounds read in snd_usb_ge=
t_audioformat_uac3()
      CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush=
()
      CVE-2025-38239: scsi: megaraid_sas: Fix invalid node index
    added commits:
      CIP: Bump version suffix to -cip4 after merge from stable
      arm64: dts: renesas: r9a09g047: Add ICU node
      irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
      irqchip/renesas-rzv2h: Add RZ/G3E support
      irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
      irqchip/renesas-rzv2h: Update TSSR_TIEN macro
      irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
      irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
      irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
      irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()
      irqchip/renesas-rzv2h: Use devm_reset_control_get_exclusive_deasserte=
d()
      irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
      irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
      irqchip/renesas-rzv2h: Fix wrong variable usage in rzv2h_tint_set_typ=
e()
      irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver
      dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E=
 SoC
      dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt Co=
ntroller
      reset: Add devres helpers to request pre-deasserted reset controls
      reset: replace boolean parameters with flags parameter
      arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52
      arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
      dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
      dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC
      clk: renesas: r9a09g057: Add clock and reset entries for GE3D
      clk: renesas: r9a09g057: Add entries for the DMACs
      clk: renesas: r9a09g047: Add clock and reset entries for GE3D
      clk: renesas: rzv2h: Refactor PLL configuration handling
      clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP
      clk: renesas: r9a09g047: Add CANFD clocks and resets
      clk: renesas: r9a09g047: Add CRU0 clocks and resets
      clk: renesas: r9a09g047: Add ICU clock/reset

Best regards,
  Nobuhiro



