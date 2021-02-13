from logging import getLogger
from celery.utils.log import get_task_logger


CLOG = get_task_logger(__name__)
LOG = getLogger(__name__)


class L:
    """ Colormap for the terminal output in the case
    of warnings and errors. """
    HEADER = '\033[95m'
    INFO = '\033[94m'
    SUCCESS = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'