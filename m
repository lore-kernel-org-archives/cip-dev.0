Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6214C433FE
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 21:41:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.165188.1669758076297935651
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Nov 2022 13:41:17 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 2ATLepBL029579; Wed, 30 Nov 2022 06:40:51 +0900
X-Iguazu-Qid: 2wHI04dX0cEqVVuuS9
X-Iguazu-QSIG: v=2; s=0; t=1669758051; q=2wHI04dX0cEqVVuuS9; m=WjtCPydXw65qnbNDhpp9Vyvk6vxvi/WbEsG9qQUpv/o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 2ATLelDZ010202
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 30 Nov 2022 06:40:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQpLlSYuFNpjFHuMui7suGEXSr1YiVh/x+Buq0PYukk3nf6Ot7D3RTH66UZiXGnziYN0kQSt+NiKTOhz7fZyeFmYZLrJp9fiS33IV1fpq2CUmb1pisjnKAYZv4EfSvgWjXqq0eCgOhBoeF47TsLl75GGkqynjAQ1vfr5fMyIkXLlnrmpR2VtCVR7Gys0iuwOAMFhfvHm6J5QzF0qiwe6C5fULTNO4HRJ4l/pKkSfAAqplErbb4Ccjl84wmqiC0iyhEf5eAN81j7AuAFmXnDgrzMwt0m9pxLMYAaBaDhSo6zz+1nds0yBGILO5wqCKH2PlwXMGE3RTjm/sj1DUZIX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKit5xpF0HWTAuOVqNaJc72wMVzofgUKlAqOPt3bFcc=;
 b=IZ79zM5QA38ItYuQtX0FBxct6CtffG3BF0ohNkcqif/w6FrPXnz8jPge5byX1s9eRDDn1pQWlc/4WRUZ8LYYwg7CQcZsGo1RLDhFztAFBdkGMhdvmlQP1XSf7EqEcY2Aw5fDyc7AS0DHQ4KM7wQ6XcjvGVVxCp806lKzzJNP3CxvwgkkSuxpJIHK5JmEVurrTi2EQ2lTvYO+j6IFwc59PX84+3O9u1h2fR96Hj0ghEeO/VezhwVQslasTmVfGDrzz+tKGvD8qXsI7xZBgK7JEHOO3h3GdOFFqq5v8/YX9JCd+GI4fGm/R/IiU1JHDeEcXO4myoGi4lKS9Groxk9kuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.4.302-cip71
Thread-Topic: [ANNOUNCE] Release v4.4.302-cip71
Thread-Index: AdkEOwUNvhTqI/4EQdqz6ZpxJbBMIA==
Date: Tue, 29 Nov 2022 21:40:45 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420CA597EDDD3AE338B17A392129@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYAPR01MB6138:EE_
x-ms-office365-filtering-correlation-id: 796e1972-3c16-47bc-45ef-08dad2525f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqjW5svEkp9bypttDrcJ2h/9CV1Ky9n9lGSIPCosiPm6IGHTRFKPCw0hFmrmkhiBW/qLQvsfnIj5UE9FpAqNl2+EA3YGHNGtGZ0TustEtvf2TxFzPQVjrhY03RKJcBYHys69le+IrWrABYyMHWp1Lf7wLUAPsCIBJlZzq6a0Hk0wKUW1ZhoiqjMEwB3SqJRCwaSyHBH4a0kWAm2aJZ5XjmdCD8M1JqSOtjVJaY+ga3WzCtEMET5txp0TtLdy5bhpOQTEkuSC05IHC7WtjkYANvZxHphO517ju/YPUNoWJVVqtYBWF/hMpuTnLxRm48TwOMSPaXCHg1id8Wyr7rk/SGMjIjbQcurRqP3+Bl1IQqlG3crRbrg2Yq4kMGHtRmKIBcRwZyeXRvdrTKPe+e2o1qw2o6OTXNIHCPWFj58/tYaKBZMl1zXHwu+Zsj6UW/NK/as/16KU541ePzBXDl0Ji/Tt3fBoA1JT2/vytSbIMDukQNd8NxekK5X/qb0oIKaIYP5k6j0WhKaf066qkdLBVgMCmEIv5GDz4uBbi5RIqTQa9kjsxNyVQ6eGTmQxy1G0W/HnbP9rWaULyJsh7MtzHpF4tDmoztAMa9wUIU6CyI2NL/UmVaM14i6EsX0qP/JXpLtCcnGhT1dYIm4pLMGgsgy2qj4zCFghQZ+NvXszd7bGHal1LXPndy9tWWOe8qhowonRhZIxi5YKtUWcDBAne9/AEixO5o6D9I9shr8jyyI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199015)(38100700002)(83380400001)(122000001)(66476007)(86362001)(76116006)(38070700005)(2906002)(41300700001)(66446008)(5660300002)(52536014)(8936002)(55016003)(4326008)(7696005)(6506007)(186003)(66556008)(26005)(966005)(9686003)(66946007)(316002)(8676002)(64756008)(54906003)(478600001)(6916009)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YWVDQmdVUzUxbjFzTnl2Mk5SQ0VRTTVmL0t0Y2k4VTFONTZNekVhV3U4?=
 =?iso-2022-jp?B?TlhxVjFaWjUxclM5UWxIZ3RqS2tBYU5RcjZsTUpGVDkwdEsxNTBEM2Fr?=
 =?iso-2022-jp?B?MWJIaVhCVEtNUmFUbmVZdjcrd0pSbGkzWEdLL09mQWt5cXRsUzY5bWxO?=
 =?iso-2022-jp?B?Um9URTEzaG0vZldmWkFlYzRFVXlzTzlQRStiZkJOQ2hUQlF4Q29NZ1h2?=
 =?iso-2022-jp?B?Y1pHMmtRMXRnSDZ2RjhVcUlTQUMzZ2YxOUk2WnJjMDd3ZDFjNGp2TFBO?=
 =?iso-2022-jp?B?NndYWFlaNXU4WEdEUzhUT0VSb2psOGJHUUZNM1h0V0ZuLzd4czRKZW15?=
 =?iso-2022-jp?B?UlhCcHJWRnZ5amk0VUJWZ3dQaHVyb2VxK004b2JKdU4wUTgrajJTZlFN?=
 =?iso-2022-jp?B?dW5KVGZCVUlaN1crSlVQbU81VHE4YnIraEIwRW9KbVV1T1ZaTUx0L3dR?=
 =?iso-2022-jp?B?a0RkOWtQVm5ka0tSQWRPaGlnQ3FtU1RnUlNKdDhSYzJuN00vdWJHMlJ3?=
 =?iso-2022-jp?B?OFIvcHhOa0d5Q0tkVHd2RU1BeE1kajlMSHoxM2hXYnlvL1ZzK1dudXdo?=
 =?iso-2022-jp?B?elhLSkRRZ3hCMlJxcStDdHFaakkydTRrM1MzUStPNys5alNwc3FIZHha?=
 =?iso-2022-jp?B?NjNkcjd4ZzBuZzRXNVRsYnlEVS9yL0oxZ2JYcForaW1IaTFscS9pWGpK?=
 =?iso-2022-jp?B?QnJzQ0VrL0NLbElZNkpPTFBHYldCUXFnVFVnV0o1L0dRUElTNFVYcTN5?=
 =?iso-2022-jp?B?czRlT2F6Skk4RHg5UGdDRWJqek8yS3QvRHdwUncyWFZNVVQxTFF2Y1Nx?=
 =?iso-2022-jp?B?djkvUU9IaU4zUnpELzNUMVpnY2JGakxuQ2pnd2JmY1FNbWgweXNnNGpT?=
 =?iso-2022-jp?B?QzdXTDIxVzhJNzVBQUxHbnk2Nk9zbTgrMFV6dklYRFc2Z0E1b1dCTytT?=
 =?iso-2022-jp?B?RHdaMEw5OHZuWks0bHBjVDFqVUwyRGE3UmRkQnRQd0tYcjFnNzZxSUJs?=
 =?iso-2022-jp?B?SDQ1dmtYUFp1ZmwrZ2pJaXhhcDNwNWpEV0xRaFJBc2VCUEYrUVgrN2JQ?=
 =?iso-2022-jp?B?VlhEWkJSVG1YYnFSd1JjSStselV2bTl1U3dwZDc2dGhoZlp3YzBhejVm?=
 =?iso-2022-jp?B?dmdMMUgxYVlad053aVAwUXZOZjNYcVBTcnRBYUoxeE8yN3FsWGIwUlVY?=
 =?iso-2022-jp?B?V1hlV3RSK0dOdlJyanloZDRBN0pKeTZNZjNPU3RKMS9DSWRYV1NYaHNv?=
 =?iso-2022-jp?B?c2pmdnBGdjRUYzlSQXhpU3NrbjRIajVmbktudW1KZnk1Yk5lUnBSdEN0?=
 =?iso-2022-jp?B?UCtkWUppTlVnT2lBaEUxbzNxTHVSWXpqWVg3Q0x5aERvcnQycThzNXZ6?=
 =?iso-2022-jp?B?dDdXS3pWckp0VEtEYlM4a1NEbmRtUHY3U3E4a0hDWldWckJOUzhydXIx?=
 =?iso-2022-jp?B?NHFYMENPZTFXUExWbGQvelZ4VTh0V2thU1R6aXEyM2hjQ2RXN3pzSk9i?=
 =?iso-2022-jp?B?NDBUVVNVY3doaTdsVFhsbVB4cmI4TFBoOVBEUmNmTjRRS2k3SEJPYW9q?=
 =?iso-2022-jp?B?ZnpWREZBWk5qb1Myb3lTVjNLN1ZuQlpPbkNxeGlNQVc4aE1iUjJqM3FT?=
 =?iso-2022-jp?B?K0doMDdQb0VHczhyK3ovbVdvZVFRRzZ0ekx6VGl3aXB1Z0E2SlVNYXBT?=
 =?iso-2022-jp?B?c2wrY1p4SU40YXpoWTk3NXA4d1RRQXBoUTN6c3A5YXhDTHBQZE1MZlhi?=
 =?iso-2022-jp?B?RjhCeVV6Vkdxa3VzVXNNZDFuVEppSFRPb2pCaCtydWo0VGxOMTIzVGtZ?=
 =?iso-2022-jp?B?dFp5Y0ZLQlRSMFZvemlmVHJmMzRBcFpFanFZdkN1Sk9EdUJCYnhsdVN3?=
 =?iso-2022-jp?B?KzZRTVBMeEFzUFhLcW85R3hES0ZURDNHUmtBY3B2Y3pEV1lKWFF6bUEx?=
 =?iso-2022-jp?B?bnNPNlZMODdTV3Job1ExbXVDeTk1M01SOFhwekFRbmdVeWlkQ0pKeUJu?=
 =?iso-2022-jp?B?RmRuOFRadVRxL095eThBT1Rqc3BkU1lXQi8zM0NiajdYK245dWtNZHZv?=
 =?iso-2022-jp?B?ZE1DeXp5STg5Y0tqMTFaR2V0M1hYdVZucSthOFg3ZDJyQ1hldUdJbFl3?=
 =?iso-2022-jp?B?MitHakRkMWpOb0ZyYkZyNTNkbEJjc0IyRkFnZE9uTnZHTmR1QXRGTHRq?=
 =?iso-2022-jp?B?SFVBTmdNVEpvMkZBUy82ZEJheGplOXNkMkRZd1BjWXkrQlhjQ0dhMEM4?=
 =?iso-2022-jp?B?N0VkTGlWK2dYZWZrOHlhUzFUT1Awc1Y2NzNIQTRVQlBJSjVuN2RvVTg1?=
 =?iso-2022-jp?B?SHFHVXZPS2gyYmJHdDlGZHZ6V0RyQzN4WFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796e1972-3c16-47bc-45ef-08dad2525f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 21:40:45.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRbTXoacco4UNoHbwhzv4UezEsQisWgYFn37aRq6QOvz8bpljsTFqV5BCnEkf0cNWRr0wtVqk0VJu6pjRYZw7ZFE12DDpARm9O0jZ4ZgUly5/HrLjJ8XDIu7TlIkcCmF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6138
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Nov 2022 21:41:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10142

Hi all,

CIP kernel team has released Linux kernel v4.4.302-cip71.
The linux-4.4.y-cip tree has been updated based on the 4.4-st28 that has be=
en backported to the
applicable patch up to 4.9.328.

You can get this release via the git tree at:

  v4.4.302-cip71:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      c727b8f0ca6857a9782a1ee857a57e4f563b34fe
    Fixed CVEs:
      CVE-2022-33744: Xen Arm guests can cause Dom0 DoS via PV devices
      CVE-2022-1462: kernel: possible race condition in drivers/tty/tty_buf=
fers.c
      CVE-2022-42703: anon_vma UAF through bogus merge of VMAs caused by
                       double-reuse of leaf anon_vma because of ->degree
                       misinterpretation
      CVE-2022-36946: kernel panic when sending nf_queue verdict with 1-byt=
e
                       nfta_payload attribute
      CVE-2022-2588: Linux kernel cls_route UAF
      CVE-2022-2318: UAF vulnerabilities in rose protocol
      CVE-2022-3028: af_key: Do not call xfrm_probe_algs in parallel
      CVE-2022-race-VM_PFNMAP-stale-TLB-entry: unmap_mapping_range() race w=
ith
                                                  munmap() on VM_PFNMAP map=
pings leads to stale TLB entry
      CVE-2022-36123: x86: Clear .brk area at early boot
      CVE-2022-39188: unmap_mapping_range() race with munmap() on VM_PFNMAP
                      mappings leads to stale TLB entry
      CVE-2022-33740: Xen Linux disk/nic frontends data leaks
      CVE-2022-26365: Xen Linux disk/nic frontends data leaks
      CVE-2021-33656: When setting font with malicous data by ioctl cmd PIO=
_FONT
                      kernel will write memory out of bounds.
      CVE-2022-36879: xfrm: xfrm_policy: fix a possible double xfrm_pols_pu=
t()
                      in xfrm_bundle_lookup()
      CVE-2022-3629: A vulnerability was found in Linux Kernel. It has been=
 declared
                     as problematic. This vulnerability affects the functio=
n
                     vsock_connect of the file net/vmw_vsock/af_vsock.c of =
the
                     component IPsec. The manipulation leads to memory leak=
. It
                     is recommended to apply a patch to fix this issue. VDB=
-211930
                     is the identifier assigned to this vulnerability.
      CVE-2022-3635: A vulnerability, which was classified as critical, has=
 been
                     found in Linux Kernel. Affected by this issue is the f=
unction
                     tst_timer of the file drivers/atm/idt77252.c of the co=
mponent
                     IPsec. The manipulation leads to use after free. It is
                     recommended to apply a patch to fix this issue.
                     VDB-211934 is the identifier assigned to this vulnerab=
ility.

Best regards,
   Nobuhiro


