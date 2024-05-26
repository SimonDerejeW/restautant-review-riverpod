import { Test, TestingModule } from '@nestjs/testing';
import { AdminFuncService } from './admin_func.service';

describe('AdminFuncService', () => {
  let service: AdminFuncService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AdminFuncService],
    }).compile();

    service = module.get<AdminFuncService>(AdminFuncService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
