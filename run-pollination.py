# coding=UTF-8
# hardcoded demo runner script for the pollination model

import time
import sys
import os
import logging
import natcap.invest.pollination

logging.basicConfig(stream=sys.stdout, level=logging.WARN)

def now():
    return int(time.time() * 1000.0)
start_ms = now()
print('[INFO] starting up')

dataDir = u'/data/pollination'

args = {
    u'farm_vector_path': dataDir + u'/farms.shp',
    u'guild_table_path': dataDir + u'/guild_table.csv',
    u'landcover_biophysical_table_path': dataDir + u'/landcover_biophysical_table.csv',
    u'landcover_raster_path': dataDir + u'/landcover.tif',
    u'results_suffix': u'',
    u'workspace_dir': u'/workspace/pollination',
}

if __name__ == '__main__':
    ptvsd_enable = os.getenv('PTVSD_ENABLE', default=0)
    if ptvsd_enable == '1':
        print('[INFO] Remote debugging, via ptvsd, is enabled')
        # somewhat following https://vinta.ws/code/remotely-debug-a-python-app-inside-a-docker-container-in-visual-studio-code.html
        import ptvsd
        ptvsd_port = int(os.getenv('PTVSD_PORT', default=3000))
        ptvsd.enable_attach(address=('0.0.0.0', ptvsd_port))
        print('[INFO] ptvsd is started (port=%d), waiting for you to attach...' % ptvsd_port)
        ptvsd.wait_for_attach()
        print('[INFO] debugger is attached, breakpointing so you can set your own breakpoints')
        breakpoint()
    print('[INFO] starting execution of pollination model')
    natcap.invest.pollination.execute(args)
    elapsed_time = now() - start_ms
    print('[INFO] finished execution of pollination model, elapsed time {}ms'.format(elapsed_time))
