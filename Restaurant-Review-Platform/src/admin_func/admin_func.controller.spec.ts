import { Test, TestingModule } from '@nestjs/testing';
import { AdminFuncController } from './admin_func.controller';
import { AdminFuncService } from './admin_func.service';

describe('AdminFuncController', () => {
  let controller: AdminFuncController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AdminFuncController],
      providers: [AdminFuncService],
    }).compile();

    controller = module.get<AdminFuncController>(AdminFuncController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
