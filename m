Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54ADC3DA7F
	for <webhook@archiver.kernel.org>; Fri, 26 Jul 2024 11:45:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.58920.1721994324380517474
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jul 2024 04:45:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=RkLYDxD5;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1721994301;x=1723203901;bh=q2
	p/LrkUXh6P+RRm2wQpar1ZOkIPQNMP3Zpl1NBfaT4=;b=RkLYDxD5psQSXioj35zQ1t4g4DyicYhz
	/9qzje5ELln84ivNVIF2Gter0DJr+DX6uC+eqMxVwRXqOkasTCzMwmmQJpqkOKHqlJZJSKukFxVg5
	DAKVdLJIdsZGTsfDrC9b/jNzYvrbZOOjbcjiSVJsP44546h1Ukb27miyiOnlY7zjraY+ABlfNP1t/
	0zvr6Yehxb6gI/MMDQfJQm69mDUP4A7+g18GqCIKduBnNOwihdF09aP0suibkAdiirvfHcpAsPpgh
	0hwokSb6DgWFY4ljWPbnxLkp5jVc989valaGBAnNgSWEaVivm+qKEOXB7CvLp1lWab0olX9KWtXgm
	hQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 46QBj0Q31942151; Fri, 26 Jul 2024 20:45:00 +0900
X-Iguazu-Qid: 2yAbD4A8ys9hTG8V4j
X-Iguazu-QSIG: v=2; s=0; t=1721994300; q=2yAbD4A8ys9hTG8V4j; m=gkykXsAztJtGHdp0M/Y81TQKqgtD0rfhvTxvU/2Q4sM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 46QBiwbr1069348
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 20:44:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0IMOac1PbXbWZuhnwjdArjrB/Zs/P54du7QKtnL9vbIXXSqDz/JCFIeetZVxTJD8Tu+X9YTB8C08/ach/Gc0/AOqUzuTFJ4FbZuGNFJGXoFe3czjFt1gqzP6xAuzEk5DuxV6iWYd13+doRyAknNGOadXx+mm27owqd6KIJJogB6NUoD9Id21PDCSQ/Hi1oXzgfrbDT4xl5LFexX0xOIvqeipkykCbkhAtJ4U06ktU4zxgruMOW2LPcd7+5yRaEUuaeWaAIF8I/qbgmNr1cMIh5R2AeJ0xgJR/qDpn3YoXpi9lZzbD3CjLWGuGHMerV+eM69I3o7UpMNu0sfjVEf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTMJgigjMW5w0NYMnzDwJpqx08GLR3pQPb7KOwHlbjc=;
 b=PbKntTis9n3Bkru2UyFPaTkgtAFU646WuUDThwDNP0o/43uQsLRGwOiRD6Z/ZaY2TzCrGi/4D+gMpzZR5waJp3fOeZoXQpeXVAFKCSkgT64B4pKZUnqb85EJaqSb97Vp+ihQs4ZRSMXY9WJeHbaNxrnAIMJTVvpSr0z7eWLQMSaA304NUo8sOv3oFoUpSZK9CvdLzpK8Bljt2YHLPpUn0l3xe9Co/vup256vRHwhHZgQ5CZFCQ0UCLy5aamYmPbnk226oJJeneTmVsy6u6T5iQ+AeoHCkElNVWPF9SvcT/Q96bxi+DIStoFtpKb52IZC+cerOAB1lpZ2ITEsTQwTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.101-cip25
Thread-Topic: [ANNOUNCE] Release v6.1.101-cip25
Thread-Index: AdrfURrZVJqwNJ3tQASLLpruvFYhdQ==
Date: Fri, 26 Jul 2024 11:44:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388A89E888284C947F36C1F92B42@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB6944:EE_
x-ms-office365-filtering-correlation-id: a0310279-faa7-497f-00f3-08dcad685f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?K3dKZ00xTXdldDdsUVhtYzBmWTdBbEFKQU0yVlJhTHVOVE9tcUplOERj?=
 =?iso-2022-jp?B?R29tbVlnL2Fic1lwR0Nxb0VxVUNkenF5Tm9RS0o5M09IK2FjazkxZVJC?=
 =?iso-2022-jp?B?VXd6bjFNUHdDalp3MnpRMmhlNTVlcHA5QVNvU3NJMlRaRHNRQlFhVDZq?=
 =?iso-2022-jp?B?SEhyYzNMYVBlZVZGT1FtWjBMUU9zOEJJa2lmNXlVY3dmZVhZRE53NlNH?=
 =?iso-2022-jp?B?QTY2M2pNRXNCdU9waVVjbUp6aWZYbWZBWUcrY0ZrNnNGek80eGtMU05P?=
 =?iso-2022-jp?B?VFkvTFNqR0JORTRwdVZLZUdWT010MjI3c1BkTStzNnFxVmtPcGR6bCt2?=
 =?iso-2022-jp?B?SjVYallRV3d1ZERHczQzOFhmdlVtZHpOZzkzb2l1ZkkwSWk4aUtOMXRN?=
 =?iso-2022-jp?B?Y0F6TVAxdk9iaUIxVWc1Sit1VzNmVTcvWk5XMWRaMTRNOTBqTUdmcmxZ?=
 =?iso-2022-jp?B?R2RCVjd3UUROMUc5TkFiR3YvVUVuVTZ1Um54TmFPTEt5QnA3KzhCSTl0?=
 =?iso-2022-jp?B?ZjFpdHp0U0U4UTBhU1pVNWZkRWVILzFDZ2ZJWFV6QU5EL3FjTytUZDZD?=
 =?iso-2022-jp?B?NHJhYys1TmI4MHJhK2lEYStOaytZTm5BVDFSanQzYWluU29GcnFQdVla?=
 =?iso-2022-jp?B?bkZsYmg4TmE2MGFaOG93aTA0TXlyNG1zS3VEMzR2cGVRekwwTUdicWZr?=
 =?iso-2022-jp?B?Z25OcUU2bkoyd0xJTksxMFV4TmxrTFZxemtZZkVicWEyZEk5UGpVb0px?=
 =?iso-2022-jp?B?UXZMZ0poSXFSUFYxUHlmQS9OMVVWRGNyY3BZK2tTUktWR25GSWtETGdz?=
 =?iso-2022-jp?B?QXdRSWxob2d2ZlBZZXNGREpvdGM1aW53aHhLZC9oRFRQcHpUMEttT2ZY?=
 =?iso-2022-jp?B?ZXE5bDBRMzFQTDMrU3k1WWFJS0FNR1ppdStsN3J3dkNtckUzWXFEVWpX?=
 =?iso-2022-jp?B?RWZYNzNRQ3lSdGtIeUloMDl5Z09ZMERqMWNaNjBGUW55blRCMjc0eTJk?=
 =?iso-2022-jp?B?ZDY1RTZmenZNNHM1WVExYlNNeUxDQ0ZGMkJ1YlVHYm1IRGR6aHlndFlQ?=
 =?iso-2022-jp?B?Ui9kcHRicXRWUTN6VWRVcC9ac1ZTZjdYVmFxTit3S25oTXpVbkxBa1Q1?=
 =?iso-2022-jp?B?cS93ZXhKNnduSHN4VnczSklXZkNoL0xKNnlOZlYzWWxSSGZiOE9qRWRU?=
 =?iso-2022-jp?B?YkdyeTdNK3I5czhvYTloVXNxcHRBSE4zMHBrRU50WFFsTDlmYWR1T3c4?=
 =?iso-2022-jp?B?aWZ4SDZCU09UL1dBeVlpOW1ZVFgyM1BEWWFzRWJpeWxrUG1MY2diZGZa?=
 =?iso-2022-jp?B?OFBPYW5XSVZ3ZGptNlNOR050cy81djR1R3BkWGNGR012UjloaXJzaTFX?=
 =?iso-2022-jp?B?M0NDb3B3S251ZUxUK3MxOTdrWXR4cGljQWRsVThSdXN6TENQVk1pRU5M?=
 =?iso-2022-jp?B?WUNQWnBZbjF1QnRBM2lnS3VzZDY5T0xmWXBFaDFkcERaMllkeWhVY1Zk?=
 =?iso-2022-jp?B?WExZRDhzRThHWGVLY28weWtJczUySi80VEFQUVJqcWY5emplUk95ZWd2?=
 =?iso-2022-jp?B?UmZrZ1pLVHUyQ0c4Ni81eGx6RnVqNWwvOVFtc281dnJnTFBGSnVnNVJ5?=
 =?iso-2022-jp?B?YmR1R2pYTjIzZzlKM3RmOTJIbDRsQVE1WjUyV2JTNUliMVpraHUxdmNS?=
 =?iso-2022-jp?B?Zi9IbGdjY284VmMzWE9YaWJKeHlFSmdZeDFIVVJybTBySFlwQnR0WVcr?=
 =?iso-2022-jp?B?Y1d5bHNtZnh3akV0ZEZOQm9jWlNkS0hROEdVcDd1ZHB4WmtDcGprbmVs?=
 =?iso-2022-jp?B?cUpzRlh0dzliUEJNdUorSGlWRmV1YUUvTFRRdm5BRkRQZ2QxZHJXSENt?=
 =?iso-2022-jp?B?NEthVEFGQ2ljRE96bnF2ZzN6VS9FbmFjT1BLeFZmTSsxWWRtS3orYXll?=
 =?iso-2022-jp?B?WWxibjN1S3VuamRmVmtieDY0aUFhR3NNZk9uR2hCTnpiZ0xCUTlXUXN4?=
 =?iso-2022-jp?B?VW1SeG5UckNoZXFoU1Flb3M4OU83MVJ1bEowRlpXYng5azgxcDV5YWdH?=
 =?iso-2022-jp?B?VGhjcDFVVlVMN1VKcTZHS3lETElPajV0QlROY2ZjdytUMFdzdGRpUE4w?=
 =?iso-2022-jp?B?cm8=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K1J2OFNjLzZNbWdSQXl0WHcvMHRaRi9EOTUzanpPQVNxbTBQQkJrRTYz?=
 =?iso-2022-jp?B?WDBaY3JLNXJ3bktEUjRRNkR6VDVGS1F0UEVKVUJQQkM3cmRlcXZwQTRk?=
 =?iso-2022-jp?B?UlRIMWhwbDJiODFTZGRVeVgwTFVNdGNFbFRlTEsyd1JxeWxrRnRlY0xx?=
 =?iso-2022-jp?B?M21vMnRLMXdGMVlUazdoMDR0YlNUdjdJWCtiZitYZXpVNFVydFRmaFh5?=
 =?iso-2022-jp?B?VmhQMjBLdDhLUmM5YkhIYTdYRmQzMUJYb0FBYmEvT3pOenlRa3VEWFlh?=
 =?iso-2022-jp?B?cFNYVm82cWlzRDdPYlI2aWM5SUpub2xGOEdTb1NRQlg4cUxYdUQ5TFRJ?=
 =?iso-2022-jp?B?Rk1iQWx6YkwwY3k0aVdtREd5b1Y1d2JTTDBlczFHVURPMW5BZTM3Z1pq?=
 =?iso-2022-jp?B?c21sdm5PY1NpalU3cG81T0JMT095WDZQZVF6aFE0YVN5dHlpWDA2ZTlH?=
 =?iso-2022-jp?B?dHVpUXB6T04xNGNsbVUrTzczak9pOUdpMFJhMlMrQnVLMGpOcUFoV1Jm?=
 =?iso-2022-jp?B?ejYydU5RWkwrYXdLUlZ6Nk9CcU11ZzBBbzZMWlBnbWlrTlErZUpEdnpu?=
 =?iso-2022-jp?B?cytwdjNEdklSVWZPVWs1MTgwYVNyTVhOalV5SnloTEdEUFRPUEFKVmxT?=
 =?iso-2022-jp?B?TW9sdDRNUEMrcGUzcGFKbW9zb2NaU01zWDBJeml0YURTKzVwZStGRzRU?=
 =?iso-2022-jp?B?SVpZbFNVdzFoVnVJVFpXdndycGhjakU1M0FjeEk0VFZVam9GSlJCNG9o?=
 =?iso-2022-jp?B?OVU5RHNnbitlRkZISnFSL3VVdnY3ZzRGbkNkUU16OVdkRmphRXNnM1M5?=
 =?iso-2022-jp?B?Qk5ESFViK0RDSWlSMmI5aU5CcGd0WkQ0WUF3VnZ4cVArbXB3VTlWUlpC?=
 =?iso-2022-jp?B?WkN4bDFqSENjVERhNWF1eWtMcGo1TzNRT0dSK3NxL3hkVURSbVlrYUNL?=
 =?iso-2022-jp?B?a2RVSzlFdFlRMDg1YTd3UEZkRysyay9aNGRqNzBoaExJY2dqTVdvOGgw?=
 =?iso-2022-jp?B?MUdnc09GVDhVTHJNVm9CZGhiaThQWXZFeVpSVm9nNllvdzJCSUlaQXZH?=
 =?iso-2022-jp?B?S1ZhZ3BGdDdZbG15Z2wrM3kwL2JnQ3Y4elY4ajd1R2pja1hSckZsM2xP?=
 =?iso-2022-jp?B?U3ZvNS8xakd2SGNjMXlOZUJVUGZHakxJNHFUYlcxRXNvNE43c2tlTGZr?=
 =?iso-2022-jp?B?UlhkWmJrVW9GTlk4UDN2ZFZkSHRsQTBjdk1TZWZHaUVIcUMxaitEOUpk?=
 =?iso-2022-jp?B?cXBIanhvS1F0bldZZHRiTmZvRDF3NUkzRWs0QWtmRmc4NlB0Y2t5UW1v?=
 =?iso-2022-jp?B?L2tZKzlWcGVaRnJHVkcvdWZUaXczempFN21nZnZOMWdDZllEU0VabTJk?=
 =?iso-2022-jp?B?ZVVYQm10OUJSSlBEcmVmc1YwaWpkTWl5bGVEK2R6a05iM0dxQytLVU9V?=
 =?iso-2022-jp?B?SzhlVXhSTGJRbFpPUUY5SWtNY1BnMkZXNzNHNGh0WGlyTVVTVFVMRjEw?=
 =?iso-2022-jp?B?TEJ5OU95Qjg5NW5iWWIzQXZka2xGSW9Eb2lTSEw5WFlpYytPTXdwSm8y?=
 =?iso-2022-jp?B?VXpZVUV2d096V1N1akhzc2g1dFVBYmEvRDZxZ0E0Qit0ZU9kRkl5NmR2?=
 =?iso-2022-jp?B?LzN4MEI3K1pSUlV1Ym0rZHNOVDFKSkFOTUFScStDalorRWdIaGtRbkd6?=
 =?iso-2022-jp?B?UXlUOXJUQzliZ0tUUlJvS0I3bmRwM3kxdWsyODNBeXZvRnQ2b3RyRE9C?=
 =?iso-2022-jp?B?TWgwZVBUK0R3czNPaVphNXhOZDFjcVBSNStrR0hweEtMNS9DclNaYUFY?=
 =?iso-2022-jp?B?czhUS1BvTUdJcTVNYWY1VDMyYWdQYUJQQUxDdk04bThib1YrRWVFVFV2?=
 =?iso-2022-jp?B?WEtZME5TayszWE1EbzlkZlNoZFpLaEJhSGE1Q0V3ZjVUNDgwOVM5b0xE?=
 =?iso-2022-jp?B?alZpN2FSZDJGNEpVOTdEWVFZam1HQzhjQ2VqVXd4SHZ5Z0VHclFjUmVw?=
 =?iso-2022-jp?B?WTVjK0JLYkZzdnI2bnA2Q1FCbXBubGRTL3VzU1k5Tk1kTitleUpzeENR?=
 =?iso-2022-jp?B?bDBncmtzTldpNXJRYitUdVBhNWdka21PdmNub1VUMWpiRVR2ZmxvcGJ4?=
 =?iso-2022-jp?B?VTkrRHlSaG5ublkvU1FSeUE0Vk5iTGNCY0ZhdzVOU1R3L1N1d2pBWmpJ?=
 =?iso-2022-jp?B?STFDZ0lsR2VsWkhhZVVRZDU4cFU4ellMVXBIMy9xNlEzUys1MTlPbm5Z?=
 =?iso-2022-jp?B?VDd0akhTWTJhRitMY1ZCZzdHZUlQVDhLZVVqSFdFbzZySkJVcXlzZG1Q?=
 =?iso-2022-jp?B?S1dmTlF0RHRidit3SWRhYW1hY2dRTTljQkh1QUVuNXovRWs0QlR1QXVJ?=
 =?iso-2022-jp?B?NjFabHQwNnlTNHpKMjVwd05wQVBnMlJiTEZZTUxPSWZaaVZJaGtBMGh5?=
 =?iso-2022-jp?B?ZXlXVEpQTnhWbk0xWUtJem5iT3ZPZmtyaitBPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0310279-faa7-497f-00f3-08dcad685f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 11:44:56.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2THzCLndR94ZNOkRL4IEsjUITCG1wwFmUf3kPKgaAjweD9hXftuOko6zoptt9NB1tCTRXGsqn8CYBodecnjkMxObf5XN/16JJLFb56WJVrIgFSMvSi13YW5goc0J1eG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6944
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jul 2024 11:45:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16628

Hi all,

CIP kernel team has released Linux kernel v6.1.101-cip25.
The linux-6.1.y-cip tree has been updated base version from v6.1.96 to v6.1=
.101.
This release includes fixes for Ethernet and PMIC devices for Renesas ARM S=
oCs.

  v6.1.101-cip25:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      bd5674d39200556fdf00d5443ce363b3a134bf2b
    fixed CVEs:
      CVE-2023-52760: gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
      CVE-2024-39494: ima: Fix use-after-free on a dentry's dname.name
      CVE-2024-25741: usb/f_printer: WARNING in usb_ep_queue
      CVE-2024-27397: netfilter: nf_tables: use timestamp to check for set =
element timeout
      CVE-2024-41009: bpf: Fix overrunning reservations in ringbuf
      CVE-2024-39487: bonding: Fix out-of-bounds read in bond_option_arp_ip=
_targets_set()
      CVE-2024-40947: ima: Avoid blocking in RCU read-side critical section
      CVE-2024-41007: tcp: avoid too many retransmit packets
      CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race=
 is detected
    added commits:
      CIP: Bump version suffix to -cip25 after merge from stable
      net: ravb: Fix RX byte accounting for jumbo packets
      net: ravb: Allow RX loop to move past DMA mapping errors
      get: ravb: Count packets instead of descriptors in R-Car RX path
      ravb: Correct buffer size to map for R-Car Rx
      ravb: Unify Rx ring maintenance code paths
      ravb: Move maximum Rx descriptor data usage to info struct
      ravb: Use the max frame size from hardware info for RZ/G2L
      ravb: Create helper to allocate skb and align it
      ravb: Make it clear the information relates to maximum frame size
      ravb: Group descriptor types used in Rx ring
      net: ravb: Count packets instead of descriptors in GbEth RX path
      Revert "arm64: dts: renesas: rzg2l: Add missing cache-level propertie=
s"
      arm64: defconfig: Enable Renesas DA9062 PMIC
      arm64: dts: renesas: rzg2ul-smarc: Enable PMIC and built-in RTC, GPIO=
 and ONKEY
      dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
      dt-bindings: mfd: dlg,da9063: Sort child devices
      dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
      dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
      dt-bindings: mfd: dlg,da9063: Update watchdog child node
      dt-bindings: mfd: da9062: Update watchdog description
      dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
      dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061 w=
atchdog
      dt-bindings: watchdog: da9062-wdt: convert txt to yaml
      Input: da9063 - use dev_err_probe()
      Input: da9063 - drop redundant prints in probe()
      Input: da9063 - simplify obtaining OF match data
      Input: da9063 - add wakeup support
      pinctrl: da9062: Add OF table
      rtc: da9063: Use dev_err_probe()
      rtc: da9063: Use device_get_match_data()
      rtc: da9063: Make IRQ as optional
      rtc: da9063: Mark the alarm IRQ as a wake IRQ
      mfd: da9062: Simplify obtaining I2C match data
      mfd: da9062: Remove IRQ requirement
      mfd: da9062: Use MFD_CELL_OF macro

Best regards,
   Nobuhiro



