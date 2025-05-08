Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99487C3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 22:43:49 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.1768.1746744224191811713
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 May 2025 15:43:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=bweppGA9;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1746744197;x=1747953797;bh=ir
	4gnZndVxVlp9NJPTgYrsjk6eTpVVPRUN2kpkyf2XI=;b=bweppGA9aX28Xn/3Bs0EA6KDfFxH72kP
	4hh6FYMg1Mmppsy4+hHbD/lxiG51bk2PBONdAw9aL/n+LwgEYgeZ/0MvLtuVIWAAGV2DPoeothI9t
	dKcXoiRMG3LHNYpa8eGUgmkqRSHmSe1v6DBivYtxZ5tqHaUx7yw1ItYjTaA7DZCu4TBIn8f++KzBs
	zlwvBa3BMI/Jrr5lGAP4OKjWcUqkL362hpabOZD21b4xbOcM+rnau7HWLzdQFq9r5tlpxa2xeacFk
	nyuZOvI/qVhI8D39ij2fdvQzKztecCkg53s3m74+W2KboCL+/PILd3OAerjKOLEQ26HgpgA5ogHZn
	VQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 548MhGtW1709066; Fri, 9 May 2025 07:43:16 +0900
X-Iguazu-Qid: 2rWhyCKR78vQ0ha75U
X-Iguazu-QSIG: v=2; s=0; t=1746744196; q=2rWhyCKR78vQ0ha75U; m=1HrPtmDH07ym1QJErCt2avTrBECHmXW9Zx/hK+4PkAk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 548MhDwM1367222
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 9 May 2025 07:43:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTyIKxW/3emcILksbPexIb9Z2epqULkEZctEor+zbzzCneu0ZlAr0Rw8uY7AS9vaf0S4GuiWEU/9B1yPi1CVJtZ1C+S8FNbo0C1hNPtDuAlVmBDGbJT78Bgiwfru+1CRPWtaU+za61BIj/rRNStUBd+JbqaqwUAVXBKPXyNPD7MvnCwIGkbe+659v8+UyLWvJw4IDfA4aZrqdUfplpkJMcwM4/KJ9tPJMHKuICiFqrJAhi5GWkVXgNAoE2bHFHzG08sWFH9yPWfC2jP3lsxc8yhC9NvNmy6EOqkng9p8UGJm6l+qwRNzkpJqZisDcnvxntfCaeX6qBTBnZAZbjhgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7YXm3MI+eq6swPp8CpmE1CHw9o4726sYds1LGz/9dU=;
 b=zIk4UjgiruPVBuiSj5NeCuhBO3yl0zPdVeBMsAyQvwT2PGxUa46ccj8MOiDNACeftKmXN6Ztw/tIxsI12fLK1ijVNUZ+nbtUxwtjmmKA0w1FT6JI2Ta57ZqKcLFPq6PJeGG07tkZ1DrqLdz0Zq9sQOOB7OEDzLSgSal415qygU3SCXFZTqEo3BQdV3EjtrWOkCJ92VItqvUHR7+z+Y4nAq5TcZ2xB+davZwKIkF9mb4OVUC0hE0EsVWRKyrDHQynBU7J1DTjeCcoKwYTG91j01zCQDZ/uyKxFXysH6hzN/iYZle2wKBh37nIjnmG6fpqf8cM3CwB9wQAkTQNSdqUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.1.137-cip42
Thread-Topic: [ANNOUNCE] Release v6.1.137-cip42
Thread-Index: AdvAantwb5Jw23PgSs+RtUbmmoS07A==
Date: Thu, 8 May 2025 22:43:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB14808C90768549D67C596D07F928BA@OS7PR01MB14808.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|TYBPR01MB5392:EE_
x-ms-office365-filtering-correlation-id: 84c06545-4880-4b6c-42c2-08dd8e81b633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ejJQSzR3RlVxRGJsa2djeUFURSttZ3dFMS83RDFicUVpT0dSNHNzMnVt?=
 =?iso-2022-jp?B?aXlhS2lVQTVCNE1jSmd1ejFOR0hVWG5QR2NZZEladmdXNXF0QTJKSzRW?=
 =?iso-2022-jp?B?R2hlVG1BK3MrV2lpWVFpeVhIbjZya3FCS0xHdE5UZDFJU2prVkUvbWF6?=
 =?iso-2022-jp?B?blh1aXlOZnFUcnFxMGVvK0Q0bStwWWx6T09vNXR2V2x6b3FhVFBtdmVv?=
 =?iso-2022-jp?B?U3UrYlpSYnMwejBrTG5WVzFYVG1jZEtQUjZHR0kyUmFCRkFlOWVXWUdP?=
 =?iso-2022-jp?B?L1pVd0tyQmZqYjVIc3lIYnpSdlJ3NTU4MUpBSHh5dXdWSWJkcW9SSXQ0?=
 =?iso-2022-jp?B?MlRwYi84aFN4dUkvSVMvOXF2cmh4aXMra3lOT09uT1RsdVplaDlmd3FF?=
 =?iso-2022-jp?B?VmpkaUZ0cWNzcTF0RE1tU0ZFc28rU0k4QmFldElYcS82WmMyRkh4N1Fy?=
 =?iso-2022-jp?B?NkN3Z1NYWEdOc0dWWGpyRnRXbFk0eWtYOGNtWWMwN2V3ZEZZUWpXS0ls?=
 =?iso-2022-jp?B?UnZ3VmVKdThtNHgzSUxwcUpSMHA1QVVwV0NEZDV2RjBzRmp0MERHam15?=
 =?iso-2022-jp?B?cEdsbDBFanR0S1Ixem02Z1dRMmppQ3ZKVzZhbVQ4RVAxeXU4SnhtN01t?=
 =?iso-2022-jp?B?VlZxa0l4dXFZUlJUeFNkOHNQcUIyZ3pBNklkc095eXBLMDlYU0NsclNP?=
 =?iso-2022-jp?B?aEtyR3Z5Mk1FeDFBbFZIWDlpZ1JmWTFoM3VVK2phOUpIYjh5RW9uM2ow?=
 =?iso-2022-jp?B?UlZaWkdDa3Qvc2YxWUJZMzFYd0R4dWFsdTZMbThPYW1pd2tScGtINlBF?=
 =?iso-2022-jp?B?UzAvamowV094UE54VzRBUVJscGlFcllTSnM3bE5RTnZ1WVk4SmtPS0VD?=
 =?iso-2022-jp?B?bVRlYVZ0YWZQcUpDaXlncG4vVHMrdkJTTXZqaFZ6emdOM0hJcEJlZnFM?=
 =?iso-2022-jp?B?Y1NTSllOb3BoWlVRYmdNMDVRMDhQS21lcG5rOWUyamV5WkZDWktLUlZn?=
 =?iso-2022-jp?B?TkpaYkozNWpXb0RUTkF3SWFuRmZLOGRQQTJGUWFqUSs3SlgrKzEyTUZN?=
 =?iso-2022-jp?B?Z0kvRFlTL2U5L0RhZEpsYjd4VzMyZ3doaEN5SlRUTjlwSGFQRzVheWE2?=
 =?iso-2022-jp?B?dXlNcHZpbndONitRZGZ6RDVHb01obzg1aHdHYVVlc05LWU9lYUwzRGxX?=
 =?iso-2022-jp?B?TDZEUXEvUmNNUUp2V21FNmlpV09ZNWdyc3lUZFJQdkkwOW5sdlgwWkNE?=
 =?iso-2022-jp?B?YlRGYlB3SXA0ZC9YTlU3NW9BMWIrS0g4TmVGK3lZdkRaOXJDRkhrL2Jh?=
 =?iso-2022-jp?B?MGd3blF5dEF4WGhVaEkxQUpESTRrVkRKeExKRkZyRS9vOWFMWU84RWRO?=
 =?iso-2022-jp?B?MzBrSjZEdjhhajBOQmRlaHFyeHRwSVhQam1jaHFxTmVmUUwzWnVKRnVI?=
 =?iso-2022-jp?B?R3dsd0JQeVNxVklLSS90VEc5MXIxenJ2c3RVWVhDMGsrSERIQW9ubWVV?=
 =?iso-2022-jp?B?OTlIUURrcGtyaDl1NXNMYlJ1ODk1TjEwUmtWNkxEUWkwKzNFK0REeEtH?=
 =?iso-2022-jp?B?VXI4clBvd0xhMlJEaTh5MlVNMFlieWR2UGFVM3lsUUUvVUNnT1pGQjZq?=
 =?iso-2022-jp?B?UFZPTWFVMDQ2eVpoQ3VQUWxhdkF1US83bmsrU0J1dkM3eGdHMDRYaE5V?=
 =?iso-2022-jp?B?MHRBRDFnSnBtbHREN2FDeVFVVU1VMlRKVzdSQUhHcVR5N2hCa1dlK082?=
 =?iso-2022-jp?B?TEFXOEY5aGFEUlEwaEgweU9OclBueVdaR05ONEdINVdIQmtXNkVON25O?=
 =?iso-2022-jp?B?MUFqeFFRMllzdUp2c09hdWRDczFuZ1pjbmJvT28xY3JzTUU1dElYK3Rz?=
 =?iso-2022-jp?B?N1BGR2FLc1BTT1hVR0piTGpOck1ZcUJpejJjUGZ1YmpNcUVPWmQ4TXlw?=
 =?iso-2022-jp?B?TkFvOXZ2TmU3VytKVWRDT1hJVVh2WGRXTkF3NDZlZ1lwcUJjcGkvWkNi?=
 =?iso-2022-jp?B?MzRqZWJnS1RwcERJbUZRMC81QnZ0OEJicEVnRlpWSnZTZEs4cXZZZ3dx?=
 =?iso-2022-jp?B?ZDlKL1QrTS9xYXRRdVJYK1lKQnlFK2RuQTNKTSsxR01IcExoUG05WTJw?=
 =?iso-2022-jp?B?dHZPZnM3RmJobkVQTWZsajRMVjJHUDNQQ1JCeDZmdTdrTG5uYmU2TjRC?=
 =?iso-2022-jp?B?eGJVPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L0lIS3gzS0dJQmMvcjFBL2dJaGJSTG5kdENGK1BGNnVqR2hzZm1lejBN?=
 =?iso-2022-jp?B?TENMV28zQXNIUXJ4dXNNZnZlUXdVQ1o0cFF1Vy9SYWdFdUJZbjRzMkkw?=
 =?iso-2022-jp?B?UkdKa0Jka3ByaTY4eEQ2cXVoS0tudkw4MUM5WGR2eFNpOEpVbmdaa0FL?=
 =?iso-2022-jp?B?U3NHbmU5K3VOSFdDYkZ2dnVGZGtSZkUyeklvRUdsenJWaFZMbFduSHI4?=
 =?iso-2022-jp?B?bWRVOXI3OUlocnVJdzdOeno5NDQvUk9TdFVIeUEzRm12bS90UDVxK3p4?=
 =?iso-2022-jp?B?eFpkVDFpb1BBMnhxRVZMa3ZOL0srTEtLS05HVHFWcW1pbWZDNnM4UlJ4?=
 =?iso-2022-jp?B?Z1NCY3crYitTU2lsbWpyRE84a1gvbklpT1JpWEppeDQ5TTBvTG4vYVh2?=
 =?iso-2022-jp?B?aHlzSE8vRjR5VUIyVjMwT09QbEIzQ3hobzU4R1MwQ1AvVjJ1Yk13SlFD?=
 =?iso-2022-jp?B?ejRTdlZRbTBBVFIzaGdLNFZtK2dhK25NN3hUYjNxWUhFQVROUFpJMSt0?=
 =?iso-2022-jp?B?TjM3d29DR0dJcXA5VGlzU2dmVVZaMy96NUVKQXlJVmZmVWZxVGVMeTdS?=
 =?iso-2022-jp?B?dFRwK08vOG5jNENhQmJHdTVxYVlUTkQyL1ZwV2FLclRRMDU2TWpJOGoy?=
 =?iso-2022-jp?B?bkRJOFh6U05welBNSTFya053MUJiRmo4Q3Jrc2Z0UjNhQ00rNzkrMVl3?=
 =?iso-2022-jp?B?QllRVHhxcWhCVitzQWpRYkNJVUhkcmkxeWlJUTQvTWtVVDE4RjRWNVdY?=
 =?iso-2022-jp?B?MVU2Tkw4bk02R3R4dnc5enBZV3ZxR2JvSTJFRkE4TFB1cGozR01UUTln?=
 =?iso-2022-jp?B?Vkc0akFWaTNlR25zZS93SS9jMGZDVDNBalpNTHNMcERqeG5ZTFBwb0lD?=
 =?iso-2022-jp?B?eWI1NkhPMXZvSWc3VmNpai9tNm5MdDRIQ0ZyRkNTU3RhYmdxZnQzeXdL?=
 =?iso-2022-jp?B?dEVkT0Y1SkJEZ21sZ0llZEsrcEJicTQ1ZE5Xa0hOSnN0ZlJxN3h5RUhB?=
 =?iso-2022-jp?B?aldzRU1zcnNRaHpib0pOck1WSlFENHFYcHBBUnNDLzRaOEczcHhIS1lS?=
 =?iso-2022-jp?B?Y3BxeGtCMGJTWlVHcHdieFVEeTRvbHJzS3BxQkdDQjlpZjFQb3RjQW9a?=
 =?iso-2022-jp?B?TUwxZCsvdjFXb3dGVDRSMnpWdTA2WE5hR1ZjTXN3N2owUzFmM1hJRFZ1?=
 =?iso-2022-jp?B?eDZXUHdDYUtSMDNOeVRJMTVYMFU1UytPZEMzNms3NzRNZ2EvWTFhK1dz?=
 =?iso-2022-jp?B?K0ZEeEtrOHlDMC9YQzdKdUREbWVNUEFLeko2ME91ay9pTWhIWnpObkhq?=
 =?iso-2022-jp?B?SlMwU3VqYlh4aUhWY2NSRUdBS1VCbkNHc1A2RlJTVmRBNHNlS0dnaHJG?=
 =?iso-2022-jp?B?alFjN0hFNUd3Q0s0b1pUd0RVeU1TTkVrREY1bCt6U2hrejRsQklHOStt?=
 =?iso-2022-jp?B?TkNVRUM1RmtoQk5GQ2pkK25YUVMrRHZKVDhlcTBQd0hTMDAwQm1tQ3V4?=
 =?iso-2022-jp?B?K0dBc1huMGpXaVc0WVBYK1puK28xeC9TMzAzbk5Ca09JOVY4ajk1UjhC?=
 =?iso-2022-jp?B?b0NtU2F3ZXFpNExkSnI5bUZSdXptVmxvcUFaZG16LzVYb25KbzVVNlNa?=
 =?iso-2022-jp?B?TytpRldTYUVrRFVkVmNrNFBEOFlWc0RyWkVSeGpHVitZTlZZajB4TCtZ?=
 =?iso-2022-jp?B?aHppMWZVaFlnSENHTDFnMFlpakVFK3JycTF1KzJOL2lSZisrbkJUdWxK?=
 =?iso-2022-jp?B?RTByb3grQTA5SUdxQU1lTHg2N0ZFeER1ZzdTa1JQeEY0YjQzbUpqa2Jh?=
 =?iso-2022-jp?B?LytEbC9vWFNmRWZ1ZVNCYmY0T3owZkpreE5jRWE2YkhJTXJ1ejJ4ZjVL?=
 =?iso-2022-jp?B?cVZNMWhJeWVjdkRUZXJob2lXTVVubnZtc2RZbnUzVXJLQm9xMWpMSVlF?=
 =?iso-2022-jp?B?UEZVT3JHM3lwV3VMWE9lVlVqV2JIRU9SMzJRWG5QeVk3clQzMnhuU1VO?=
 =?iso-2022-jp?B?aVozWEJucGViOUtkaUY5MGtBcVlrUk9mbTEzRTkvSjMwRHp4c2JUK2wz?=
 =?iso-2022-jp?B?QitxVno0c0o2amc5WTZIamRjbU4zUEJnYXlpUjlWaEE2MU9wVDdmeWF4?=
 =?iso-2022-jp?B?MHZmSWMyQnJVanNDZEdhMGlMdnRzQ2dyQXBsWTlDUlo0ZERibE1JNHRn?=
 =?iso-2022-jp?B?OFQvdE53UVVlRUwxV3JZc2pCVFdQeW5oSmlzQUpKbXFyTnNHWGxrbGZh?=
 =?iso-2022-jp?B?U2tKclpjSklRNENFcTg4b3EzVk9ZeWJZb2NYajVoTVpWbHJRemFRSjE3?=
 =?iso-2022-jp?B?RFFqdVAyWDl5bE1RRjJhRG9RL2hqc250eWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c06545-4880-4b6c-42c2-08dd8e81b633
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 22:43:11.4834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6z6AfemCqPvyuZ2eneOm7imEHL5iQb0ErMLeGnnCLYd0uOv4OyMrep74eXtpkrxfGJw5fAawjB37Ul53pxrLdaJLj5tHMBKnHtzoKYwcVfk0UH0Sfovwx8Fh1jKHQNG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5392
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 May 2025 22:43:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18784

Hi all,

CIP kernel team has released Linux kernel v6.1.137-cip42.
The linux-6.1.y-cip tree has been updated base version from v6.1.134 to v6.=
1.137.
This release also adds the Renesas RZ/V2H(P) SoC and evaluation board.

You can get this release via the git tree at:

  v6.1.137-cip42:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      decb0c620821d9d007a5e179968d313e303f6c73
    fixed CVEs:
      CVE-2025-37838: HSI: ssi_protocol: Fix use after free vulnerability i=
n ssi_protocol Driver Due to Race Condition
      CVE-2025-23159: media: venus: hfi: add a check to handle OOB in sfr r=
egion
      CVE-2025-23148: soc: samsung: exynos-chipid: Add NULL pointer check i=
n exynos_chipid_probe()
      CVE-2025-23147: i3c: Add NULL pointer check in i3c_master_queue_ibi()
      CVE-2025-37780: isofs: Prevent the use of too small fid
      CVE-2025-37781: i2c: cros-ec-tunnel: defer probe if parent EC is not =
present
      CVE-2025-37773: virtiofs: add filesystem context source name check
      CVE-2025-37757: tipc: fix memory leak in tipc_link_xmit
      CVE-2024-50063: bpf: Prevent tail call between progs attached to diff=
erent hooks
      CVE-2025-37770: drm/amd/pm: Prevent division by zero
      CVE-2025-37794: wifi: mac80211: Purge vif txq in ieee80211_do_stop()
      CVE-2025-37792: Bluetooth: btrtl: Prevent potential NULL dereference
      CVE-2024-46816: drm/amd/display: Stop amdgpu_dm initialize when link =
nums greater than max_links
      CVE-2024-36908: blk-iocost: do not WARN if iocg was already offlined
      CVE-2025-23142: sctp: detect and prevent references to a freed transp=
ort in sendmsg
      CVE-2024-46774: powerpc/rtas: Prevent Spectre v1 gadget construction =
in sys_rtas()
      CVE-2025-22126: md: fix mddev uaf while iterating all_mddevs list
      CVE-2025-37798: codel: remove sch->q.qlen check before qdisc_tree_red=
uce_backlog()
      CVE-2025-23157: media: venus: hfi_parser: add check to avoid out of b=
ound access
      CVE-2025-37772: RDMA/cma: Fix workqueue crash in cma_netevent_work_ha=
ndler
      CVE-2025-22013: KVM: arm64: Unconditionally save+flush host FPSIMD/SV=
E/SME state
      CVE-2025-37790: net: mctp: Set SOCK_RCU_FREE
      CVE-2025-37767: drm/amd/pm: Prevent division by zero
      CVE-2025-23161: PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t typ=
e
      CVE-2024-46733: btrfs: fix qgroup reserve leaks in cow_file_range
      CVE-2025-37739: f2fs: fix to avoid out-of-bounds access in f2fs_trunc=
ate_inode_blocks()
      CVE-2025-23146: mfd: ene-kb3930: Fix a potential NULL pointer derefer=
ence
      CVE-2025-37771: drm/amd/pm: Prevent division by zero
      CVE-2025-23156: media: venus: hfi_parser: refactor hfi packet parsing=
 logic
      CVE-2025-37740: jfs: add sanity check for agwidth in dbMount
      CVE-2025-37795: wifi: mac80211: Update skb's control block key in iee=
e80211_tx_dequeue()
      CVE-2025-37738: ext4: ignore xattrs past end
      CVE-2025-37768: drm/amd/pm: Prevent division by zero
      CVE-2025-23141: KVM: x86: Acquire SRCU in KVM_GET_MP_STATE to protect=
 guest memory accesses
      CVE-2024-46742: smb/server: fix potential null-ptr-deref of lease_ctx=
_info in smb2_open()
      CVE-2025-21853: bpf: avoid holding freeze_mutex during mmap operation
      CVE-2025-37789: net: openvswitch: fix nested key length validation in=
 the set() action
      CVE-2025-23151: bus: mhi: host: Fix race between unprepare and queue_=
buf
      CVE-2025-37756: net: tls: explicitly disallow disconnect
      CVE-2025-37788: cxgb4: fix memory leak in cxgb4_init_ethtool_filters(=
) error path
      CVE-2025-23139: Bluetooth: hci_uart: Fix another race during initiali=
zation
      CVE-2025-37749: net: ppp: Add bound checking for skb data on ppp_sync=
_txmung
      CVE-2025-37782: hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read=
_key
      CVE-2025-23140: misc: pci_endpoint_test: Avoid issue of interrupts re=
maining after request_irq error
      CVE-2025-37752: net_sched: sch_sfq: move the limit validation
      CVE-2025-23158: media: venus: hfi: add check to handle incorrect queu=
e size
      CVE-2025-37796: wifi: at76c50x: fix use after free access in at76_dis=
connect
      CVE-2025-23145: mptcp: fix NULL pointer in can_accept_new_subflow
      CVE-2025-37766: drm/amd/pm: Prevent division by zero
      CVE-2025-37787: net: dsa: mv88e6xxx: avoid unregistering devlink regi=
ons which were never registered
      CVE-2025-37741: jfs: Prevent copying of nlink with value 0 from disk =
inode
      CVE-2025-37742: jfs: Fix uninit-value access of imap allocated in the=
 diMount() function
      CVE-2025-37758: ata: pata_pxa: Fix potential NULL pointer dereference=
 in pxa_ata_probe()
      CVE-2025-37748: iommu/mediatek: Fix NULL pointer deference in mtk_iom=
mu_device_group
      CVE-2025-23150: ext4: fix off-by-one error in do_split
      CVE-2025-37769: drm/amd/pm/smu11: Prevent division by zero
      CVE-2025-23163: net: vlan: don't propagate flags on open
      CVE-2025-37765: drm/nouveau: prime: fix ttm_bo_delayed_delete oops
      CVE-2025-37778: ksmbd: Fix dangling pointer in krb_authenticate
      CVE-2025-37775: ksmbd: fix the warning from __kernel_write_iter
      CVE-2024-56609: wifi: rtw88: use ieee80211_purge_tx_queue() to purge =
TX skb
      CVE-2025-37797: net_sched: hfsc: Fix a UAF vulnerability in class han=
dling
      CVE-2025-23144: backlight: led_bl: Hold led_access lock when calling =
led_sysfs_disable()
      CVE-2024-38541: of: module: add buffer overflow check in of_modalias(=
)
      CVE-2024-26739: net/sched: act_mirred: don't override retval if we al=
ready lost the skb
    added commits:
      CIP: Bump version suffix to -cip42 after merge from stable
      arm64: dts: renesas: rzg3s-smarc-som: Enable I2C1 node
      arm64: dts: renesas: rzg3s-smarc: Enable I2C0 node
      arm64: dts: renesas: r9a08g045: Add I2C nodes
      clk: renesas: r9a08g045: Add clock, reset and power domain support fo=
r I2C
      arm64: dts: renesas: r9a08g045: Add DMAC node
      dt-bindings: dma: rz-dmac: Document RZ/G3S SoC
      clk: renesas: r9a08g045: Add DMA clocks and resets
      arm64: dts: renesas: r9a09g057: Enable SYS node
      arm64: dts: renesas: r9a09g057: Add OPP table
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable watchdog
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable OSTM, I2C, and SD=
HI
      arm64: dts: renesas: r9a09g057: Add WDT0-WDT3 nodes
      arm64: dts: renesas: r9a09g057: Add SDHI0-SDHI2 nodes
      arm64: dts: renesas: r9a09g057: Add RIIC0-RIIC8 nodes
      arm64: dts: renesas: r9a09g057: Add OSTM0-OSTM7 nodes
      arm64: dts: renesas: Add initial DTS for RZ/V2H EVK board
      arm64: dts: renesas: Add initial SoC DTSI for RZ/V2H(P) SoC
      arm64: dts: renesas: r9a08g045: Enable SYS node
      arm64: dts: renesas: r9a08g045: Update fallback string for SDHI nodes
      arm64: dts: renesas: rzg2l: Update fallback string for SDHI nodes
      arm64: dts: renesas: r9a09g011: Update fallback string for SDHI nodes
      clk: renesas: r9a09g057: Add clock and reset entries for GIC
      clk: renesas: r9a09g057: Add reset entry for SYS
      clocksource/drivers/renesas-ostm: Avoid reprobe after successful earl=
y probe
      clocksource/drivers/renesas-ostm: Allow OSTM driver to reprobe for RZ=
/V2H(P) SoC
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
      mmc: renesas_sdhi: Add RZ/V2H(P) compatible string
      dt-bindings: mmc: renesas,sdhi: Remove duplicate compatible and add c=
lock checks
      dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support
      mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, a=
nd RZ/V2M SoCs
      dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
      dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
      dt-bindings: mmc: renesas,sdhi: Group single const value items into a=
n enum list
      arm64: defconfig: Enable R9A09G057 SoC
      soc: renesas: r9a09g057-sys: Add a callback to print SoC-specific ext=
ra features
      soc: renesas: rz-sysc: Move RZ/V2H SoC detection to the SYS driver
      soc: renesas: rz-sysc: Add support for RZ/G3E family
      soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver
      soc: renesas: Add SYSC driver for Renesas RZ family
      soc: renesas: Add identification support for RZ/V2H SoC
      soc: renesas: mark OF related data as maybe unused
      dt-bindings: arm: renesas: Document Renesas RZ/V2H(P) System Controll=
er
      dt-bindings: soc: renesas: Document RZ/V2H EVK board
      dt-bindings: soc: renesas: Document Renesas RZ/V2H(P) SoC variants
      i2c: riic: Add `riic_bus_barrier()` to check bus availability
      i2c: riic: Use predefined macro and simplify clock tick calculation
      i2c: riic: Mark riic_irqs array as const
      i2c: riic: Use GENMASK() macro for bitmask definitions
      i2c: riic: Use BIT macro consistently
      i2c: riic: Use dev_err_probe in probe and riic_init_hw functions
      i2c: riic: Introduce a separate variable for IRQ
      i2c: riic: Simplify unsupported bus speed handling
      i2c: riic: Add support for fast mode plus
      i2c: riic: Define individual arrays to describe the register offsets
      i2c: riic: Add suspend/resume support
      i2c: riic: Enable runtime PM autosuspend support
      i2c: riic: Use pm_runtime_resume_and_get()
      i2c: riic: Call pm_runtime_get_sync() when need to access registers
      i2c: riic: Use temporary variable for struct device
      clk: renesas: r9a07g044: Add clock and reset entry for DRP-AI
      clk: renesas: r9a07g043: Mark mod_clks and resets arrays as const
      clk: renesas: r9a07g04[34]: Fix typo for sel_shdi variable

Best regards,
  Nobuhiro


