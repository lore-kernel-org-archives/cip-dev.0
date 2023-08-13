Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867EAEB64DD
	for <webhook@archiver.kernel.org>; Sun, 13 Aug 2023 22:27:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.95094.1691965648966134277
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Aug 2023 15:27:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 37DMR3UH3200352; Mon, 14 Aug 2023 07:27:04 +0900
X-Iguazu-Qid: 2rWh7t7B1cq6hi7Nb6
X-Iguazu-QSIG: v=2; s=0; t=1691965623; q=2rWh7t7B1cq6hi7Nb6; m=9AhtqDRalcp+ucdOlkLAxXQjOsH0shTOxzerhRHHe+g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 37DMR0h42255037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Aug 2023 07:27:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNUtON7BoFvvIW9eso6yUiyaMCnxNYexEMyZTPVPSbTRlzaUqbgY9s6ePa/7Rfe2AfC7NLZofo3Ro1TmHU0Rp+ezfV5EQQHTgIsnx/4//J123RbDPJTjjId+DaCpG+CcZwqVYXObabouaRn2nAWXU62Bfn8yK3JFoU6wAaMmharhtCcCCSu2lBOr6Tr/JF7yA7xkUiwykIW33AwkDFnsfAznbd800gB1v0xp2MEu61r5fKB3kRZvblOZe7p93DO1uB06g7fp/vtEKubnh3zQU9XNDKjaVMC82oIcfm3wzAolFZD/spYK+7tsRnTnBt+N1EjIAH2Z71W1i/rLx2AFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sM/LXpG6iyF6AsuzCxF+qeMXK2VUjU/p6egVNlwKQs=;
 b=mSmb5H7tefco9h5KWgcfy6P7DBBsT2ihSIeR6l0bFUaiztQfdTaDYbIdzZf1Qv/wSiMDKXJ1W3Q5UQQAwlqYvKW0XdeqZKnsA9PBm6woYiW5kJ6xIsN7bkBKR5RoYKUb1E+9s4Co0QsRzFP7T6zEkeq6qx10iTbpIXA1zws1ZTCLbdlxzMfgEAGZEPeCHeg92a49jRzX7M3TuX74Ym2JBwpB4ipEBujc3/w43r9FO2r0koSWhXdRB71YsPXGsoOEltpWAwU32yE8V1vYpUHOOVSEBXES7oNQU9SSxgrNwvWcwPwIvCMdLqV20wdD0blFu/N5hJ4m2lRZb62mwcV9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v6.1.45-cip3
Thread-Topic: [ANNOUNCE] Release v6.1.45-cip3
Thread-Index: AdnONRvfh6qqZo8PQNWgY/tebJwvmw==
Date: Sun, 13 Aug 2023 22:26:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94202B09013D0C19A0FB92779216A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSRPR01MB11506:EE_
x-ms-office365-filtering-correlation-id: 8a71c74a-2202-4a90-6fea-08db9c4c6750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y4yEmlhwCP/lyAWGS4hKb2Yf5HAk1pap9kmph5GqPkM0r+EDDnLNv3r5Sm/NpYufJXDl25VLPKEKizVIuWNzLTLtaJUNr9z76MX4W45ZiQH59F8riCEo635miV36ytzseA/3u+SmHp/FfzKI8HL7yfHrPDL+CZUDQC/ExJ7LJRHEX9VjQNpGP/6dnBrdfKvAsbn4/RL5bSmiA/0vVQsYDN2I/ot/6Kue7pnfON0tAbcm2QlZEsNB3HLi94fo44voeT1eNIgWAQbbc1Fi1PXd8wbXiBf8gRTiIMLuzp9ge5Sfaqcw0qjqS4BBU2M/gvafb1NYIsa75HDWUenQTJ1thR0C1UT9zy2jAYD0NFmruAlZvgwIBS1hbf01obtAaXnw2WHdsW1wR8XJFAKWvTA8FdPjOYqnF1rGQtTWF043pZ3Pkfz+X+v1tKMRGfLshvtRViRU1+TNuzaJHfWJts0cvg+e5t9T0MsaeVAu4Ag6QJ4d/R0liy0Mb4cviAZfDOiMgeEnjuYbTEtU/2kpQI56MkyQSIgRyYRtN40VyIiZWjkyy64mcPg3J+20UY1PfKXUjEZQuwAAgz4vOYhJAZPNnwAmPb1pa5T9gAb/DnEw7Bn5dkjQwzNa4dm+OBpAwxUO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(1800799006)(186006)(451199021)(83380400001)(41300700001)(8936002)(66476007)(76116006)(66446008)(66556008)(66946007)(8676002)(316002)(9686003)(966005)(26005)(6506007)(71200400001)(54906003)(7696005)(478600001)(122000001)(38100700002)(55016003)(33656002)(86362001)(64756008)(6916009)(4326008)(5660300002)(2906002)(38070700005)(52536014)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Q3hqRmF1ektEbFVLdEFrQlVudW1NYjk5N1JTdzg1amlJZ3hYZlNJLzU1?=
 =?iso-2022-jp?B?V0d3a2NVSEtzb05UbGZlRDk5VFJCa2lVb2hDWnRDVVBlL0kwN3VmU2hF?=
 =?iso-2022-jp?B?Q2FDSTBuMEJVckE4MTNvVXZ5Y2QwdzdGTXJpV1ZnYnNTTW1qQ2xER1BQ?=
 =?iso-2022-jp?B?OC9US0d5RFI2ckZoWHFJU1ZQMCtqeVBIeWkzRGFoQ2VVeWpJSTlSVzND?=
 =?iso-2022-jp?B?dVpvNVpUUnpsRWw3L0RnZEYwK2d4bitXd01XOTh1WURqNGowSnhWTzZM?=
 =?iso-2022-jp?B?OXVWcDdvU0VLYmZKOXMzNkR0dlBWRUtBL2NFRXNYSnlqc3BTaTZnSHY0?=
 =?iso-2022-jp?B?V1AyMXAxVlNlT1RyMU8rMk5sOFl5YXR6RFpCeU9ZNzNFSFMvSHZ3Wkdt?=
 =?iso-2022-jp?B?dDBvWHk0b1N2NHR2MkZKZWV4aVdGKzZZTHFyZ21SWEducUtObm5DeURX?=
 =?iso-2022-jp?B?RDVZNGIwNHlzOFg3SmtzcEVyZ3MvdHVMdkhxWWpFUnZ4VW9wd2s4aU90?=
 =?iso-2022-jp?B?T1Bsd25RRWdiTzdlSzQ2TlhacXlKcDQyOFZjcDV0TnhEdU9wZkREb2Zy?=
 =?iso-2022-jp?B?TkJaRDJQZTFyeFZlbDdmakwzcjJGNmd5ZGRib1RjKzRVZ3ErQ2dqZDFq?=
 =?iso-2022-jp?B?L3RlS21heStaYVN1bU1VejlXQzg1azBTK2MrUWVhNG9IRkM4Q3E2dWIv?=
 =?iso-2022-jp?B?K0FEVitwM2FpWUd1cWgxNmJaRVQvT0psYUNYeFNhM01jQWVLOTQ0V1N5?=
 =?iso-2022-jp?B?bUZDMEVUbGlnNVN2VWtwdmV3UmRxTGdFZ1M0dG9iSDlPSUtRN1ZGUXVR?=
 =?iso-2022-jp?B?SUhwRnVOcUN5YnMweGRxWDBXdFc4Y0tYc2FEck1iYm5LNit2eEE3eFh0?=
 =?iso-2022-jp?B?YkRHd2ZFSFFNajNjY3VJMkpCcnJQUlVFYSt0emd5TllwQkpIVDFUZzYw?=
 =?iso-2022-jp?B?TlBLVU9UdVc1aUc3TkptY1hOSjY1VEF1Y1IrcW9nMzlITkk1T1MyTy95?=
 =?iso-2022-jp?B?aElsaEJnSGNiYVhrMnovK2RrSnlZZW05Z1BXM1hmWUxwVys4SHZyR1Zs?=
 =?iso-2022-jp?B?UEVWTWRHd1I5S01RVys3eVRKV2NNdWt6YlRSSnp5ME1XOU13VzJWdVV6?=
 =?iso-2022-jp?B?M2JYQk9tNlViZGlKOGVUNWRVM2J5Vm1pV1BXTU9ZUmNicDVnTUpMa0Fp?=
 =?iso-2022-jp?B?SXZTMWFlWG1MT2JhbnNXdWtlTTFvbW1ld1E0ZHJodHRxamg5UGZGV0Fi?=
 =?iso-2022-jp?B?QTRKOXBrdmxtcGpsK1pXZ3l0SFE3d3Q5QmMwTUcwVWtGREhxWkMvWWV1?=
 =?iso-2022-jp?B?b0sreURYcy9jdjA5Z3ZobjFtM0VKWmdiVlJBYUE5dm12NUVyTzA0SXE5?=
 =?iso-2022-jp?B?NUxZZS9sekJVQzRPbGZodkwvKzFHRWE1bUVqajFvdGJoV0hpcnV6aWJQ?=
 =?iso-2022-jp?B?OWorYk0vTlJHUkloUmUxTkZQb2ZTbFMxTEY4ZFplUjF2Vy90RWdPZXNR?=
 =?iso-2022-jp?B?ZGJmWWwwMnR3WDZObHpUdnlEM3c0dDlmejVtek56KzRhSWk2QzJRQXJn?=
 =?iso-2022-jp?B?KzM3ajlwVDZ2cVpJVS9XTERvWDQwcU1aeElDSWJhVmVBT0xXZVVVcGov?=
 =?iso-2022-jp?B?K3pRNnI3TXNWT0R2TmhLTk9za2VQbTVPQVpFQW1EZWV1L0tleTZjTFVW?=
 =?iso-2022-jp?B?STF3K0hvZmFZekExQWZtK3dlRXY0Mzl2THQ3N1RleUhtMnV1SmNZQWw4?=
 =?iso-2022-jp?B?cVkycmhiZFZqUnlyZG9KSmJkeWx1Z3k0ZWM1SEt4Q2tNRGZNUG9QTHpE?=
 =?iso-2022-jp?B?dnFMVnZNeE1ZSytuWjRsQllWNGozWktJai9yT0RzUDJkYzRObTFWRUdv?=
 =?iso-2022-jp?B?SnloQjhQcmpTM0NvaHNkNkQ1MGRqL0RpcGQ2Y3VxL1RGRVlveXI5eHdt?=
 =?iso-2022-jp?B?UzFJdmZxR2pvQTFyay9MbUQxUDhDOUVpWXFmUUFxVFFHWDFSKzdJOVQv?=
 =?iso-2022-jp?B?NDlGMVE5TUVuQ3RSU3h3R2ttWmN3Zkp1dmFvWFF4a2hlM2tSZDllQkMv?=
 =?iso-2022-jp?B?d2U5OW5lTmlHaXhaVUxJVEplSEo3WkFabmJSbGlwamNyd09OYzBMV21W?=
 =?iso-2022-jp?B?WENGMUROdCtCV0hvZlZyWDJkVTUzU3JjZnpRWjl5dEZUZ1V1REdyTlNJ?=
 =?iso-2022-jp?B?NlRtdklIdjNSQlVjeUhWb05iK2FjbDNXMXNKcU1nR1oyWHlFRjBrMDV4?=
 =?iso-2022-jp?B?SnNUK1Z0MjJhSmlRS2tieE5neS9NRStZQm4xSFp1NHlHQWhDZThFSmt1?=
 =?iso-2022-jp?B?aHNaU1M3VWpia3E5TGVPbEZCMlNOeVNTT2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?TFJ2OW5UbFRNZmo4ajAyRW1JdWJPdEQrbHNkUHp4dk5XdGJGeEdnZHZu?=
 =?iso-2022-jp?B?QXJQUUkrcWlDYjd2WnhPK25jMk8rbXZVL3pLSDdiWEFSb3pxN210WEU5?=
 =?iso-2022-jp?B?OWdQNUtHVnRGWnFOUk1lei9YQWxCVWRwM2VBN1E4ekFJcitVeDJIcTQ4?=
 =?iso-2022-jp?B?em8wbW1zM1ZmS25LSjZITUlYckt6V1N5V3hrSW9ZaE1UR0picDNXaW4r?=
 =?iso-2022-jp?B?Tm05RVQ4akR5bStlNU1xMFA5OTBBMUExNXlPMkhKOGcrd3ZlUXdIYWtO?=
 =?iso-2022-jp?B?emF4L1RUZWYxRm15T203VWtxQnAyeTg3MzNMYjRoSkhheWF0MzQ2eFJv?=
 =?iso-2022-jp?B?K0h1cVJJd0pXcUh5VGo4akxqU056M2hzbXFmU0pkbThnNE1VNzh3MS9H?=
 =?iso-2022-jp?B?OXY2cVVaWmVMVGcwQ1REUnZLZkd1V09lakllV201cGQvNWlPOGdGaGRv?=
 =?iso-2022-jp?B?dzBmYWQ5U2tWdzEybUs1VFFRRUhCTmwrcWZsdFlYVVhkZjNrWHhRVW4y?=
 =?iso-2022-jp?B?YTJnRmUrY0w1eXA0RWVTcUFvTGhtT2ljNjVTZXU2MXd6ZU44RGJ1SDVW?=
 =?iso-2022-jp?B?QnVTNHd5cHpkT1FsazRZRFg4UTZJNjVwTjNKTUFHWldUNFQwRWpkeXU5?=
 =?iso-2022-jp?B?OWJhektEZFl5NWcvaVhVcnBMbURtc2tVLzY1Q3Q5RDk2UkkvZDdXZEJs?=
 =?iso-2022-jp?B?NWtGblFTbDQrS0hCMDd2R3JyZUtvSUNVRVpOdjVVelREN25PZmYxS0l0?=
 =?iso-2022-jp?B?YjI3OGV3UGFJYUUyUGZ5NkVkUUdTZkFNNkRRNC8vdC8wRzM0L01lVXlV?=
 =?iso-2022-jp?B?QndsQzRxY2wvQ1VISVB5aUpiaUNnQ2JwWEZRK1NpN1kxa1NRT2plN3JF?=
 =?iso-2022-jp?B?aGpJaE8zM2MvOFdWYy9MZ3F6WDVZY1lXY2NNTERTMW1WY3lvclNLWk9Z?=
 =?iso-2022-jp?B?MXl2VVkwRGlvL09GQURMTC9PRlF6cXRoR2t2ZEl2SUVaR0tlTDk5cEgv?=
 =?iso-2022-jp?B?T2dtRHl3cXM3QndHRjRVSDlYNG1yMHpPMWR2a0h0d2g2Qk5Qcms1K3Vv?=
 =?iso-2022-jp?B?M0kveHBUcjU0cFBKSTgzUjZDNC9TL2twa1N0Q0cwVXI0UkZGYlFSRjNZ?=
 =?iso-2022-jp?B?djdiTlNtQkVEVHVpakR2RVcyOG5mdTdyZXRkRmtBZytvZzhoVXo0NWd1?=
 =?iso-2022-jp?B?OUplcy9zNmtpNTA4SWNKN1lMVTFvWDhOMFpGOXpodWd5SUg1TjhJL0Zj?=
 =?iso-2022-jp?B?WmFwNjljWURDV1VKUytlb25iaWxGWGlZQVcvYXlrNnRGVjFSZGt2MlZ1?=
 =?iso-2022-jp?B?ckdZRVNkMXJUL01lR3FWZjFFaVdxTWVkNXVUd3VoQ2IyZWRvM0s4WlZa?=
 =?iso-2022-jp?B?UXBESS9PdTJxVHNqek53dz09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a71c74a-2202-4a90-6fea-08db9c4c6750
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 22:26:56.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47AYFj88q8UrDPuLElt4Q6q+FLeOem2eaTK4D8Ig5WL+ojt+PFKxJ8ae/946L5GsY0/CLXXQfU2qdrJTA+rGC7WYIO72A9VusKizHbwLvaSWsijv6VDlSGK/roxRMJlT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11506
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Aug 2023 22:27:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12620

Hi all,

CIP kernel team has released Linux kernel v6.1.45-cip3.
The linux-6.1.y-cip tree has been updated base version from v6.1.42 to v6.1=
.45.

You can get this release via the git tree at:

  v6.1.45-cip3:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      9854793aeaee837123cc2be25bbdf869fa5ba5e8
    Fixed CVEs:
      CVE-2023-4194: tap: tap_open(): correctly initialize socket uid next =
fix of i_uid to current_fsuid
      CVE-2023-4273: exfat: check if filename entries exceeds max filename =
length
      CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the net/s=
ched classifiers: cls_fw, cls_u32 and cls_route
      CVE-2023-20588: x86/CPU/AMD: Do not leak quotient data after a divisi=
on by 0
      CVE-2023-34319: xen/netback: Fix buffer overrun triggered by unusual =
packet
      CVE-2022-40982: Downfall attacks
      CVE-2023-20569: Speculative Return Stack Overflow (SRSO)
      CVE-2023-4015: netfilter: nf_tables: skip immediate deactivate in _PR=
EPARE_ERROR
      CVE-2023-1206: hash collisions in the IPv6 connection lookup table
      CVE-2023-4147: netfilter: nf_tables: disallow rule addition to bound =
chain via NFTA_RULE_CHAIN_ID
      CVE-2023-3995: [netfilter: nf_tables: disallow rule addition to bound=
 chain via NFTA_RULE_CHAIN_ID]
    added commits:
      CIP: Bump version suffix to -cip3 after merge from stable
      tty: serial: sh-sci: Fix sleeping in atomic context

Best regards,
   Nobuhiro


